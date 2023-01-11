$script:ModuleName = 'AzDevOps';
$script:Source = Join-Path $PSScriptRoot $ModuleName;
$script:Output = Join-Path $PSScriptRoot output;
$script:Destination = Join-Path $Output $ModuleName;
$script:ModuleList = @('core', 'build', 'operations');
$script:Assemblies = Join-Path $Destination assemblies;
$script:ModulePath = "$Destination\$ModuleName.psm1";
$script:ManifestPath = "$Destination\$ModuleName.psd1";
$script:Imports = ('public', 'authentication\public', 'authentication\private', 'build\public', 'build\private', 'operations\public', 'operations\private', 'processes\public', 'processes\private', 'projects\public', 'projects\private', 'teams\public', 'teams\private');
$script:PublicFunctions = ('authentication\public', 'build\public', 'operations\public', 'processes\public', 'projects\public', 'teams\public');
$script:TestFile = ("TestResults_$(Get-Date -Format s).xml").Replace(':', '-');
$script:SourceId = [System.Guid]::NewGuid().Guid;

Import-Module BuildHelpers;

<#
Write-Output $script:ModuleName
Write-Output $script:Source
Write-Output $script:Output
Write-Output $script:ModulePath
Write-Output $script:ManifestPath
Write-Output $script:Imports
Write-Output $script:PublicFunctions
Write-Output $script:TestFile
#>

Task LocalUse -description "Use for local testing" -depends Clean, BuildManifest
Task CIUSe -description "Use for pipeline deployments" -depends BuildModule, BuildManifest

Task Clean {
 $null = Remove-Item $Output -Recurse -ErrorAction Ignore
 $null = New-Item -Type Directory -Path $Destination
}

Task BuildModule -description "Compile the Build Module" -depends clean, BuildNestedModules, BuildNestedManifests -action {
 $ModulePath = Join-Path $script:Source $script:ModuleName;
 $ModuleDestination = Join-Path $script:Destination $script:ModuleName;
 [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()
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

Task BuildManifest -description "Compile the Module Manifest" -depends BuildModule -action {
 $ModulePath = Join-Path $script:Source $script:ModuleName;
 $ModuleDestination = $script:Destination;
 $CurrentManifestPath = "$($ModulePath)\$($script:ModuleName).psd1"
 Write-Output "$($script:Source)"
 Write-Output "  Update [$ModuleDestination]"
 $Functions = @()
 $NestedModules = $ModuleList |ForEach-Object {"$($_)\$($_).psd1"}
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