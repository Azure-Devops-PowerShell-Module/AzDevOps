# .ExternalHelp teams-help.xml
[cmdletbinding()]
param()
Write-Verbose "This psm1 is replaced in the build output. This file is only used for debugging."
Write-Verbose $PSScriptRoot

Write-Verbose 'Import everything in sub folders'
foreach ($folder in @('classes', 'private', 'public', 'includes', 'internal'))
{
 $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
 if (Test-Path -Path $root)
 {
  Write-Verbose "processing folder $root"
  $files = Get-ChildItem -Path $root -Filter *.ps1

  # dot source each file
  $files | where-Object { $_.name -NotLike '*.Tests.ps1' } |
  ForEach-Object { Write-Verbose $_.basename; . $_.FullName }
 }
}