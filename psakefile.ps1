$script:ModuleName = 'AzDevOps';
$script:GithubOrg = 'Azure-Devops-PowerShell-Module'
$script:Source = Join-Path $PSScriptRoot $ModuleName;
$script:Output = Join-Path $PSScriptRoot output;
$script:Docs = Join-Path $PSScriptRoot 'docs'
$script:Destination = Join-Path $Output $ModuleName;
$script:ModuleList = @('core', 'build', 'operations');
$script:ModulePath = "$Destination\$ModuleName.psm1";
$script:ManifestPath = "$Destination\$ModuleName.psd1";
$script:Imports = ('public', 'authentication\public', 'authentication\private', 'build\public', 'build\private', 'operations\public', 'operations\private', 'processes\public', 'processes\private', 'projects\public', 'projects\private', 'teams\public', 'teams\private');
$script:TestFile = ("TestResults_$(Get-Date -Format s).xml").Replace(':', '-');
$script:SourceId = [System.Guid]::NewGuid().Guid;
$script:Repository = "https://github.com/$($script:GithubOrg)"
$script:PoshGallery = "https://www.powershellgallery.com/packages/$($script:ModuleName)"

Import-Module BuildHelpers;
Import-Module PowerShellForGitHub;

<#
Write-Output $script:ModuleName
Write-Output $script:Source
Write-Output $script:Output
Write-Output $script:ModulePath
Write-Output $script:ManifestPath
Write-Output $script:Imports
Write-Output $script:TestFile
#>

Task LocalUse -description "Use for local testing" -depends Clean, BuildNestedModules, BuildNestedManifests, BuildModule , BuildManifest

Task Build -depends LocalUse, PesterTest
Task Package -depends CreateExternalHelp, CreateCabFile, UpdateReadme
Task Deploy -depends ReleaseNotes, PublishModule, NewTaggedRelease, Post2Discord


Task Clean {
 $null = Remove-Item $Output -Recurse -ErrorAction Ignore
 $null = New-Item -Type Directory -Path $Destination
 $Global:settings = Get-Content .\ado.token.json | ConvertFrom-Json;
 foreach ($Name in ($Global:settings | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name))
 {
  $Org = $Global:settings.$Name;
  $ExpirationDate = Get-Date($Org.Expiration);
  $Today = (Get-Date(Get-Date -Format yyyy-MM-dd));
  $DateDiff = New-TimeSpan -Start $Today -End $ExpirationDate;
  if ($DateDiff.TotalDays -le 7)
  {
   Write-Host -ForegroundColor Red "Warning: $($Org.OrgName) Token Expires : $($Org.Expiration)";
  }
  else
  {
   Write-Host -ForegroundColor Blue "Info: $($Org.OrgName) Token Expires in $($DateDiff.TotalDays) days"
  }
 }
}

Task BuildModule -description "Compile the Build Module" -action {
 $ModulePath = Join-Path $script:Source $script:ModuleName;
 $ModuleDestination = Join-Path $script:Destination $script:ModuleName;
 [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()
 [void]$stringbuilder.AppendLine( "# .ExternalHelp AzDevOps-help.xml" )
 [void]$stringbuilder.AppendLine( "Write-Verbose 'Importing from [$($ModulePath)]'" )
 if (Test-Path "$($ModulePath)")
 {
  $fileList = Get-ChildItem -Recurse -Path "$($ModulePath)\*.ps1" -Exclude "*.Tests.ps1"
  foreach ($file in $fileList)
  {
   $shortName = $file.BaseName
   Write-Output "  Importing [.$shortName]"
   [void]$stringbuilder.AppendLine( "# .$shortName" )
   [void]$stringbuilder.AppendLine( [System.IO.File]::ReadAllText($file.fullname) )
  }
 }

 Write-Output "  Creating module [$ModuleDestination]"
 Set-Content -Path  "$($ModuleDestination).psm1" -Value $stringbuilder.ToString()
}

Task BuildManifest -description "Compile the Module Manifest" -action {
 $ModulePath = $script:Source #$script:ModuleName;
 $ModuleDestination = $script:Destination;
 $CurrentManifestPath = "$($ModulePath)\$($script:ModuleName).psd1"
 Write-Output "$($script:Source)"
 Write-Output "  Update [$ModuleDestination]"
 $Functions = @()
 $NestedModules = $ModuleList | ForEach-Object { "$($_)\$($_).psd1" }
 foreach ($Folder in (Get-ChildItem -Path $ModulePath -Directory))
 {
  if (Test-Path -Path $Folder.FullName)
  {
   $FileList = Get-ChildItem -Recurse -Path $Folder.FullName -Filter "*.ps1" -Exclude "*.Tests.ps1";
   foreach ($File in $FileList)
   {
    $AST = [System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref]$null, [ref]$null);
    $Name = $AST.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true).Name
    $Functions += $Name;
   }
  }
  Update-Metadata -Path $CurrentManifestPath -PropertyName FunctionsToExport -Value $Functions
 }
 Update-Metadata -Path $CurrentManifestPath -PropertyName NestedModules -Value $NestedModules;
 Update-Metadata -Path $CurrentManifestPath -PropertyName ModuleList -Value $NestedModules;
 Copy-Item $CurrentManifestPath -Destination $ModuleDestination
}

Task BuildNestedModules -description "Build the nested modules" -action {
 foreach ($ModuleName in $script:ModuleList)
 {
  $ModuleFolder = (Get-Item -Path "$($script:Source)\$($ModuleName)").FullName;
  $ModuleDestination = Join-Path $script:Output $script:ModuleName $ModuleName
  $ModulePath = Join-Path $ModuleDestination "$($ModuleName).psm1"

  [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new();
  foreach ($Folder in (Get-ChildItem -Path $ModuleFolder))
  {
   [void]$stringbuilder.AppendLine( "Write-Verbose 'Importing from [$Folder]'" )
   if (Test-Path -Path $Folder.FullName)
   {
    $FileList = Get-ChildItem $Folder.FullName -Recurse -Filter "*.ps1" -Exclude "*.Tests.ps1";
    foreach ($File in $FileList)
    {
     $shortName = $file.BaseName
     Write-Output "  Importing [.$shortName]"
     [void]$stringbuilder.AppendLine( "# .$shortName" )
     [void]$stringbuilder.AppendLine( [System.IO.File]::ReadAllText($file.fullname) )
    }
   }
  }
  if (!(Test-Path -Path $ModuleDestination))
  {
   $null = New-Item -Path $ModuleDestination -ItemType Directory;
  }
  Write-Output "  Creating module [$($ModulePath)]";
  Set-Content -Path  $ModulePath -Value $stringbuilder.ToString();
 }
}

Task BuildNestedManifests -description "Build the nested module manifest files" -action {
 foreach ($ModuleName in $script:ModuleList)
 {
  $ModuleFolder = (Get-Item -Path "$($script:Source)\$($ModuleName)").FullName;
  $ModuleDestination = Join-Path $script:Output $script:ModuleName $ModuleName;
  $CurrentManifestPath = "$($ModuleFolder)\$($ModuleName).psd1"
  $ManifestPath = Join-Path $ModuleDestination "$($ModuleName).psd1";
  Write-Output "  Update [$ManifestPath]";
  $Functions = @();
  foreach ($Folder in (Get-ChildItem -Path $ModuleFolder -Directory))
  {
   if (Test-Path -Path $Folder.FullName)
   {
    $FileList = Get-ChildItem -Recurse -Path $Folder.FullName -Filter "*.ps1" -Exclude "*.Tests.ps1";
    foreach ($File in $FileList)
    {
     $AST = [System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref]$null, [ref]$null);
     $Name = $AST.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true).Name
     $Functions += $Name;
    }
   }
   Update-Metadata -Path $CurrentManifestPath -PropertyName FunctionsToExport -Value $Functions
  }
  Copy-Item $CurrentManifestPath -Destination $ManifestPath;
 }
}

Task PesterTest -description "Test module" -action {
 $TestResults = Invoke-Pester -OutputFormat NUnitXml -OutputFile $TestFile
 if ($TestResults.FailedCount -gt 0)
 {
  Write-Error "Failed [$($TestResults.FailedCount)] Pester tests"
 }
}

Task UpdateHelp -Description "Update the help files" -Action {
 Import-Module -Name "$($script:Output)\$($script:ModuleName)" -Scope Global -force;
 New-MarkdownHelp -Module $script:ModuleName -AlphabeticParamsOrder -UseFullTypeName -WithModulePage -OutputFolder $script:Docs -ErrorAction SilentlyContinue
 Update-MarkdownHelp -Path $script:Docs -AlphabeticParamsOrder -UseFullTypeName
}

Task CreateExternalHelp -Description "Create external help file" -Action {
 New-ExternalHelp -Path $script:Docs -OutputPath "$($script:Output)\$($script:ModuleName)" -Force
}

Task CreateCabFile -Description "Create cab file for download" -Action {
 New-ExternalHelpCab -CabFilesFolder "$($script:Output)\$($script:ModuleName)" -LandingPagePath "$($script:Docs)\$($script:ModuleName).md" -OutputFolder "$($PSScriptRoot)\cabs\"
}

Task UpdateReadme -Description "Update the README file" -Action {
 $readMe = Get-Item .\README.md

 $TableHeaders = "| Latest Version | PowerShell Gallery | Issues | License | Discord |"
 $Columns = "|-----------------|----------------|----------------|----------------|----------------|"
 $VersionBadge = "[![Latest Version](https://img.shields.io/github/v/tag/$($script:GithubOrg)/$($script:ModuleName))]($($script:Repository)/$($script:ModuleName)/tags)"
 $GalleryBadge = "[![Powershell Gallery](https://img.shields.io/powershellgallery/dt/$($script:ModuleName))](https://www.powershellgallery.com/packages/PoshMongo)"
 $IssueBadge = "[![GitHub issues](https://img.shields.io/github/issues/$($script:GithubOrg)/$($script:ModuleName))]($($script:Repository)/$($script:ModuleName)/issues)"
 $LicenseBadge = "[![GitHub license](https://img.shields.io/github/license/$($script:GithubOrg)/$($script:ModuleName))]($($script:Repository)/$($script:ModuleName)/blob/master/LICENSE)"
 $DiscordBadge = "[![Discord Server](https://assets-global.website-files.com/6257adef93867e50d84d30e2/636e0b5493894cf60b300587_full_logo_white_RGB.svg)]($($DiscordChannel))"

 if (!(Get-Module -Name $script:ModuleName )) { Import-Module -Name $script:Destination }

 Write-Output $TableHeaders | Out-File $readMe.FullName -Force
 Write-Output $Columns | Out-File $readMe.FullName -Append
 Write-Output "| $($VersionBadge) | $($GalleryBadge) | $($IssueBadge) | $($LicenseBadge) | $($DiscordBadge) |" | Out-File $readMe.FullName -Append

 Get-Content "$($PSScriptRoot)\Overview.md" | Out-File $readMe.FullName -Append
 Get-Content "$($script:Docs)\$($script:ModuleName).md" | Select-Object -Skip 8 | ForEach-Object { $_.Replace('(', '(Docs/') } | Out-File $readMe.FullName -Append
 Write-Output "" | Out-File $readMe.FullName -Append
}

Task NewTaggedRelease -Description "Create a tagged release" -Action {
 $Github = (Get-Content -Path "$($PSScriptRoot)\github.token") | ConvertFrom-Json
 $Credential = New-Credential -Username ignoreme -Password $Github.Token
 Set-GitHubAuthentication -Credential $Credential
 if (!(Get-Module -Name $script:ModuleName )) { Import-Module -Name "$($script:Output)\$($script:ModuleName)" }
 $Version = (Get-Module -Name $script:ModuleName | Select-Object -Property Version).Version.ToString()
 git add .
 git commit . -m "Updated ExternalHelp for $($Version) Release"
 git push
 git tag -a v$version -m "$($script:ModuleName) Version $($Version)"
 git push origin v$version
 New-GitHubRelease -OwnerName $script:GithubOrg -RepositoryName $script:ModuleName -Tag "v$($Version)" -Name $Version
}

Task Post2Discord -Description "Post a message to discord" -Action {
 $version = (Get-Module -Name $($script:ModuleName) | Select-Object -Property Version).Version.ToString()
 $Discord = Get-Content .\discord.poshmongo | ConvertFrom-Json
 $Discord.message.content = "Version $($version) of $($script:ModuleName) released. Please visit Github ($($script:Repository)/$($script:ModuleName)) or PowershellGallery ($($PoshGallery)) to download."
 Invoke-RestMethod -Uri $Discord.uri -Body ($Discord.message | ConvertTo-Json -Compress) -Method Post -ContentType 'application/json; charset=UTF-8'
}


Task CreateNuSpec -Description "Create NuSpec file for upload" -Action {
 .\ConvertTo-NuSpec.ps1 -ManifestPath "$($script:Output)\$($script:ModuleName)\$($script:ModuleName).psd1" -DestinationFolder $script:Output
 [xml]$nuspec = Get-Content "$($script:Output)\$($script:ModuleName).nuspec";
 Write-Output " Removing nuspec dependencies"
 $nuspec.package.metadata.RemoveChild($nuspec.package.metadata.dependencies) | Out-Null;
 $nuspec.Save("$($script:Output)\$($script:ModuleName).nuspec");
}

Task NugetPack -Description "Pack the nuget file" -Action {
 nuget pack "$($script:Output)\$($script:ModuleName).nuspec" -OutputDirectory $script:Output -verbosity detailed
}

Task NugetPush -Description "Push nuget to PowerShell Gallery" -Action {
 $config = [xml](Get-Content "$($PSScriptRoot)\nuget.config")
 nuget push "$($script:Output)\*.nupkg" -NonInteractive -ApiKey "$($config.configuration.apikeys.add.value)" -ConfigFile "$($PSScriptRoot)\nuget.config"
}

Task ReleaseNotes -Action {
 $Github = (Get-Content -Path "$($PSScriptRoot)\github.token") | ConvertFrom-Json
 $Credential = New-Credential -Username ignoreme -Password $Github.Token
 Set-GitHubAuthentication -Credential $Credential
 $Milestone = (Get-GitHubMilestone -OwnerName $script:GithubOrg -RepositoryName $script:ModuleName -State Closed |Sort-Object -Property ClosedAt)[0]
 [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()
 [void]$stringbuilder.AppendLine( "# $($Milestone.title)" )
 [void]$stringbuilder.AppendLine( "$($Milestone.description)" )
 [void]$stringbuilder.AppendLine( "--" )
 $i = Get-GitHubIssue -OwnerName $script:GithubOrg -RepositoryName $script:ModuleName -RepositoryType All -Filter All -State Closed -MilestoneNumber $Milestone.Number;
 $headings = $i | ForEach-Object { $_.Labels.Name } | Sort-Object -Unique;
 foreach ($heading in $headings)
 {
  [void]$stringbuilder.AppendLine( "" )
  [void]$stringbuilder.AppendLine( "## $($heading.ToUpper())" )
  [void]$stringbuilder.AppendLine( "" )
  $issues = $i | ForEach-Object { if ($_.Labels.Name -eq $Heading) { $_ } }
  foreach ($issue in $issues)
  {
   [void]$stringbuilder.AppendLine( "* $($issue.title) #$($issue.issuenumber)" )
  }
 }
 Out-File -FilePath "$($PSScriptRoot)\RELEASE.md" -InputObject $stringbuilder.ToString() -Encoding ascii -Force
}

Task InstallMarkdig -Action {
 nuget install Markdig -Source "https://api.nuget.org/v3/index.json" -outputdirectory "$($script:Output)\MarkDig"
 $Folder = (Get-ChildItem -Path "$($script:Output)\MarkDig\Markdig*").FullName
 Add-Type -Path (Get-Item "$($Folder)\lib\net6.0\Markdig.dll").FullName
}

Task PublishModule -Description "Publish module to PowerShell Gallery" -depends InstallMarkdig -Action {
 $config = [xml](Get-Content "$($PSScriptRoot)\nuget.config");
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 $Parameters = @{
  Path = $script:Destnation
  NuGetApiKey = "$($config.configuration.apikeys.add.value)"
  LicenseUri = "$($script:Repository)/$($script:ModuleName)/blob/master/LICENSE"
  ReleaseNotes = [Markdig.Markdown]::ToHtml((Get-Content "$($PSScriptRoot)\RELEASE.md"))
  Tag = "PowerShell","Azure DevOps"
  IconUri = "$($script:Repository)/$($script:ModuleName)/raw/master/logo.png"
  ProjectUri = "$($script:Repository)/$($script:ModuleName)"
 }
 Publish-Module @Parameters;
}