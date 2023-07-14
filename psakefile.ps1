$script:ModuleName = 'AzDevOps';
$script:GithubOrg = 'Azure-Devops-PowerShell-Module'
$script:Source = Join-Path $PSScriptRoot $ModuleName;
$script:Output = Join-Path $PSScriptRoot output;
$script:Docs = Join-Path $PSScriptRoot 'docs'
$script:Destination = Join-Path $Output $ModuleName;
$script:ModuleList = @('core', 'build', 'operations', 'git');
$script:ModulePath = "$Destination\$ModuleName.psm1";
$script:ManifestPath = "$Destination\$ModuleName.psd1";
$script:TestFile = ("TestResults_$(Get-Date -Format s).xml").Replace(':', '-');
$script:Repository = "https://github.com/$($script:GithubOrg)"
$script:PoshGallery = "https://www.powershellgallery.com/packages/$($script:ModuleName)"
$script:DeployBranch = 'master'

$CurrentBuildHelpers = Get-Module -ListAvailable | Where-Object -Property Name -eq BuildHelpers;
$PotentialBuildHelpers = Find-Module -Name BuildHelpers;
$CheckVersion = [System.Version]::new($CurrentBuildHelpers.Version).CompareTo([System.Version]::new($PotentialBuildHelpers.Version));
if ($CurrentBuildHelpers)
{
 Write-Host -ForegroundColor Blue "Info: BuildHelpers Version $($CurrentBuildHelpers.Version) Found";
 switch ($CheckVersion)
 {
  0
  {
   Write-Host -ForegroundColor Blue "Info: BuildHelpers Version $($CurrentBuildHelpers.Version) is the latest version";
  }
  1
  {
   Write-Host -ForegroundColor Yellow "Warning: BuildHelpers Version $($CurrentBuildHelpers.Version) is newer than the latest version $($PotentialBuildHelpers.Version)";
  }
  -1
  {
   Write-Host -ForegroundColor Red "Warning: BuildHelpers Version $($CurrentBuildHelpers.Version) is older than the latest version $($PotentialBuildHelpers.Version)";
  }
 }
 Write-Host -ForegroundColor Blue "Info: This automation built with BuildHelpers Version 2.0.16";
 Import-Module BuildHelpers;
}
else
{
 throw "Please Install-Module -Name BuildHelpers";
}
$CurrentPowerShellForGitHub = Get-Module -ListAvailable | Where-Object -Property Name -eq PowerShellForGitHub;
$PotentialPowerShellForGitHub = Find-Module -Name PowerShellForGitHub;
$CheckVersion = [System.Version]::new($CurrentPowerShellForGitHub.Version).CompareTo([System.Version]::new($PotentialPowerShellForGitHub.Version));
if ($CurrentPowerShellForGitHub)
{
 Write-Host -ForegroundColor Blue "Info: PowerShellForGitHub Version $($CurrentPowerShellForGitHub.Version) Found";
 switch ($CheckVersion)
 {
  0
  {
   Write-Host -ForegroundColor Blue "Info: PowerShellForGitHub Version $($CurrentPowerShellForGitHub.Version) is the latest version";
  }
  1
  {
   Write-Host -ForegroundColor Yellow "Warning: PowerShellForGitHub Version $($CurrentPowerShellForGitHub.Version) is newer than the latest version $($PotentialPowerShellForGitHub.Version)";
  }
  -1
  {
   Write-Host -ForegroundColor Red "Warning: PowerShellForGitHub Version $($CurrentPowerShellForGitHub.Version) is older than the latest version $($PotentialPowerShellForGitHub.Version)";
  }
 }
 Write-Host -ForegroundColor Blue "Info: This automation built with PowerShellForGitHub Version 0.16.1";
 Import-Module PowerShellForGitHub;
}
else
{
 throw "Please Install-Module -Name PowerShellForGitHub";
}
$CurrentPsScriptAnalyzer = Get-Module -ListAvailable | Where-Object -Property Name -eq PSScriptAnalyzer
$PotentialPsScriptAnalyzer = Find-Module -Name PSScriptAnalyzer
$CheckVersion = [System.Version]::new($CurrentPsScriptAnalyzer.Version).CompareTo([System.Version]::new($PotentialPsScriptAnalyzer.Version));
if ($CurrentPsScriptAnalyzer)
{
 Write-Host -ForegroundColor Blue "Info: PSScriptAnalyzer Version $($CurrentPsScriptAnalyzer.Version) Found";
 switch ($CheckVersion)
 {
  0
  {
   Write-Host -ForegroundColor Blue "Info: PSScriptAnalyzer Version $($CurrentPsScriptAnalyzer.Version) is the latest version";
  }
  1
  {
   Write-Host -ForegroundColor Yellow "Warning: PSScriptAnalyzer Version $($CurrentPsScriptAnalyzer.Version) is newer than the latest version $($PotentialPsScriptAnalyzer.Version)";
  }
  -1
  {
   Write-Host -ForegroundColor Red "Warning: PSScriptAnalyzer Version $($CurrentPsScriptAnalyzer.Version) is older than the latest version $($PotentialPsScriptAnalyzer.Version)";
  }
 }
 Write-Host -ForegroundColor Blue "Info: This automation built with PSScriptAnalyzer Version 1.21.1";
 Import-Module PSScriptAnalyzer;
}
else
{
 throw "Please Install-Module -Name PSScriptAnalyzer";
}

Write-Host -ForegroundColor Green "ModuleName   : $($script:ModuleName)";
Write-Host -ForegroundColor Green "Githuborg    : $($script:Source)";
Write-Host -ForegroundColor Green "Source       : $($script:Source)";
Write-Host -ForegroundColor Green "Output       : $($script:Output)";
Write-Host -ForegroundColor Green "Docs         : $($script:Docs)";
Write-Host -ForegroundColor Green "Destination  : $($script:Destination)";
Write-Host -ForegroundColor Green "ModulePath   : $($script:ModulePath)";
Write-Host -ForegroundColor Green "ManifestPath : $($script:ManifestPath)";
Write-Host -ForegroundColor Green "TestFile     : $($script:TestFile)";
Write-Host -ForegroundColor Green "Repository   : $($script:Repository)";
Write-Host -ForegroundColor Green "PoshGallery  : $($script:PoshGallery)";
Write-Host -ForegroundColor Green "DeployBranch : $($script:DeployBranch)";

Task LocalUse -description "Use for local testing" -depends Clean, BuildNestedModules, BuildNestedManifests, BuildModule , BuildManifest

Task Build -depends LocalUse, PesterTest
Task Package -depends CreateExternalHelp, CreateCabFile, UpdateReadme
Task Deploy -depends CheckBranch, ReleaseNotes, PublishModule, NewTaggedRelease, Post2Discord


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
 $GalleryBadge = "[![Powershell Gallery](https://img.shields.io/powershellgallery/dt/$($script:ModuleName))](https://www.powershellgallery.com/packages/AzDevOps)"
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
 #$Version = (Get-Module -Name $script:ModuleName | Select-Object -Property Version).Version.ToString();
 $ModuleManifest = Test-ModuleManifest .\AzDevOps\AzDevOps.psd1 -ErrorAction SilentlyContinue;
 $Version = $ModuleManifest.Version.ToString();
 git add .
 git commit . -m "Updated ExternalHelp for $($Version) Release"
 git push
 git tag -a v$version -m "$($script:ModuleName) Version $($Version)"
 git push origin v$version
 New-GitHubRelease -OwnerName $script:GithubOrg -RepositoryName $script:ModuleName -Tag "v$($Version)" -Name "v$($Version)"
}

Task Post2Discord -Description "Post a message to discord" -Action {
 $version = (Get-Module -Name $($script:ModuleName) | Select-Object -Property Version).Version.ToString()
 $Discord = Get-Content .\discord.azdevops | ConvertFrom-Json
 $Discord.message.content = "Version $($version) of $($script:ModuleName) released. Please visit Github ($($script:Repository)/$($script:ModuleName)) or PowershellGallery ($($PoshGallery)) to download."
 Invoke-RestMethod -Uri $Discord.uri -Body ($Discord.message | ConvertTo-Json -Compress) -Method Post -ContentType 'application/json; charset=UTF-8'
}

Task ReleaseNotes -Description "Create release notes file for module manifest" -Action {
 $Github = (Get-Content -Path "$($PSScriptRoot)\github.token") | ConvertFrom-Json
 $Credential = New-Credential -Username ignoreme -Password $Github.Token
 Set-GitHubAuthentication -Credential $Credential
 $Milestone = (Get-GitHubMilestone -OwnerName $script:GithubOrg -RepositoryName $script:ModuleName -State Closed | Sort-Object -Property MilestoneNumber -Descending)[0]
 if ($Milestone)
 {
  [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()
  [void]$stringbuilder.AppendLine( "# $($Milestone.title)" )
  [void]$stringbuilder.AppendLine( "$($Milestone.description)" )
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
}

Task CheckBranch -Description "A test that should fail if we deploy while not on master" -Action {
 $branch = git branch --show-current
 if ($branch -ne $script:DeployBranch)
 {
  [System.Net.WebSockets.WebSocketException]$Exception = "You are not on the deployment branch: $($script:DeployBranch)"
  [string]$ErrorId = "Git.WrongBranch"
  [System.Management.Automation.ErrorCategory]$Category = [System.Management.Automation.ErrorCategory]::InvalidOperation
  $PSCmdlet.ThrowTerminatingError(
   [System.Management.Automation.ErrorRecord]::new(
    $Exception,
    $ErrorId,
    $Category,
    $null
   )
  )
 }
}

Task PublishModule -Description "Publish module to PowerShell Gallery" -Action {
 $config = [xml](Get-Content "$($PSScriptRoot)\nuget.config");
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 $Parameters = @{
  Path        = $script:Destination
  NuGetApiKey = "$($config.configuration.apikeys.add.value)"
 }
 Publish-Module @Parameters;
}

Task NewModule -Description "A task to build a new module" -Action {
 $ModuleName = Read-Host -Prompt "Enter the name of the module";
 $ManifestPath = Read-Host -Prompt "Enter the path to the module manifest file";
 $Description = Read-Host -Prompt "Enter the description for the module";
 $Author = 'jeffrey@patton-tech.com';
 $CompanyName = 'Patton-Tech.com';
 $CopyRight = (Get-Date)
 $Guid = (New-Guid).Guid;
 $ModuleVersion = '1.0.0';
 $RootModule = "$($ModuleName).psm1";
 if ($ManifestPath.Contains('.psd1'))
 {
  $Count = $ManifestPath.Split('\').Count;
  $ManifestFileName = $manifestPath.Split('\')[$Count - 1];
  $TestPath = $ManifestPath.Replace($ManifestFileName, '');
  if (!(Test-Path -Path $TestPath))
  {
   if (!($ModuleName.endswith('s')))
   {
    $PluralizedModuleName = "$($ModuleName)s";
   }
   $ModuleRootPath = (Join-Path $TestPath $PluralizedModuleName)
   $ModulePublicCodePath = (Join-Path $ModuleRootPath 'Public')
   $ModulePrivateCodePath = (Join-Path $ModuleRootPath 'Private')
   $TestPath = New-Item -Path $TestPath -ItemType Directory;
   $ModuleRootPath = New-Item -Path $ModuleRootPath -ItemType Directory;
   $ModulePublicCodePath = New-Item -Path $ModulePublicCodePath -ItemType Directory;
   $ModulePrivateCodePath = New-Item -Path $ModulePrivateCodePath -ItemType Directory;
  }
  New-ModuleManifest -Path $ManifestPath -Description $Description -Author $Author -CompanyName $CompanyName -Copyright $CopyRight -Guid $Guid -ModuleVersion $ModuleVersion -RootModule $RootModule;
 }
 else
 {
  $TestPath = $ManifestPath;
  if (!(Test-Path -Path $TestPath))
  {
   if (!($ModuleName.endswith('s')))
   {
    $PluralizedModuleName = "$($ModuleName)s";
   }
   $ModuleRootPath = (Join-Path $TestPath $PluralizedModuleName)
   $ModulePublicCodePath = (Join-Path $ModuleRootPath 'Public')
   $ModulePrivateCodePath = (Join-Path $ModuleRootPath 'Private')
   $TestPath = New-Item -Path $TestPath -ItemType Directory;
   $ModuleRootPath = New-Item -Path $ModuleRootPath -ItemType Directory;
   $ModulePublicCodePath = New-Item -Path $ModulePublicCodePath -ItemType Directory;
   $ModulePrivateCodePath = New-Item -Path $ModulePrivateCodePath -ItemType Directory;
  }
  $ManifestFileName = "$($ModuleName).psd1";
  $ManifestPath = (Join-Path $TestPath $ManifestFileName);
  New-ModuleManifest -Path $ManifestPath -Description $Description -Author $Author -CompanyName $CompanyName -Copyright $CopyRight -Guid $Guid -ModuleVersion $ModuleVersion -RootModule $RootModule;
 }
 Write-Host -ForegroundColor Green "Setting up Nested Module";
 Write-Host -ForegroundColor Green "ModuleName            : $($ModuleName)";
 write-host -ForegroundColor Green "ManifestPath          : $($ManifestPath)";
 Write-Host -ForegroundColor Green "Description           : $($Description)";
 Write-Host -ForegroundColor Green "Author                : $($Author)";
 Write-Host -ForegroundColor Green "CompanyName           : $($CompanyName)";
 Write-Host -ForegroundColor Green "CopyRight             : $($CopyRight)";
 Write-Host -ForegroundColor Green "Guid                  : $($Guid)";
 Write-Host -ForegroundColor Green "ModuleVersion         : $($ModuleVersion)";
 Write-Host -ForegroundColor Green "RootModule            : $($RootModule)";
 Write-Host -ForegroundColor Green "TestPath              : $($TestPath.FullName)";
 Write-Host -ForegroundColor Green "PluralizedModuleName  : $($PluralizedModuleName)";
 Write-Host -ForegroundColor Green "ManifestFileName      : $($ManifestFileName)";
 Write-Host -ForegroundColor Green "ModuleRootPath        : $($ModuleRootPath.FullName)";
 Write-Host -ForegroundColor Green "ModulePublicCodePath  : $($ModulePublicCodePath.FullName)";
 Write-Host -ForegroundColor Green "ModulePrivateCodePath : $($ModulePrivateCodePath.FullName)";
}