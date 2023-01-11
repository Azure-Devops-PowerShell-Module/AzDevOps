$script:ModuleName = 'AzDevOps';
$script:Source = Join-Path $PSScriptRoot $ModuleName;
$script:Output = Join-Path $PSScriptRoot output;
$script:Destination = Join-Path $Output $ModuleName;
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

Task LocalUse -description "Use for local testing" -depends Clean, BuildModule, BuildManifest
Task CIUSe -description "Use for pipeline deployments" -depends BuildModule, BuildManifest

Task Clean {
 $null = Remove-Item $Output -Recurse -ErrorAction Ignore
 $null = New-Item -Type Directory -Path $Destination
}

Task BuildModule -description "Compile the Build Module" -action {
 [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()
 foreach ($folder in $imports )
 {
  [void]$stringbuilder.AppendLine( "Write-Verbose 'Importing from [$Source\$folder]'" )
  if (Test-Path "$source\$folder")
  {
   $fileList = Get-ChildItem "$source\$folder\*.ps1" -Exclude "*.Tests.ps1"
   foreach ($file in $fileList)
   {
    $shortName = $file.BaseName
    Write-Output "  Importing [.$shortName]"
    [void]$stringbuilder.AppendLine( "# .$shortName" )
    [void]$stringbuilder.AppendLine( [System.IO.File]::ReadAllText($file.fullname) )
   }
  }
 }
 Write-Output "  Creating module [$ModulePath]"
 Set-Content -Path  $ModulePath -Value $stringbuilder.ToString()
}

Task BuildManifest -description "Compile the Module Manifest" -depends BuildModule -action {
 Write-Output "  Update [$ManifestPath]"
 Copy-Item "$Source\$ModuleName.psd1" -Destination $ManifestPath
 $Functions = @()
 foreach ($Folder in $PublicFunctions)
 {
  if (Test-Path "$Source\$Folder")
  {
   $FileList = Get-ChildItem "$($Source)\$($Folder.Replace('public',''))*.psd1"
   foreach ($File in $FileList)
   {
    $Functions += Get-Metadata -Path $File.FullName -PropertyName FunctionsToExport
   }
  }
 }
 Update-Metadata -Path $ManifestPath -PropertyName FunctionsToExport -Value $Functions
}

Task PesterTest -description "Test module" -action {
 $TestResults = Invoke-Pester -OutputFormat NUnitXml -OutputFile $TestFile
 if ($TestResults.FailedCount -gt 0)
 {
  Write-Error "Failed [$($TestResults.FailedCount)] Pester tests"
 }
}