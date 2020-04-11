Task default -depends ModulesToExport

Task ModulesToExport {
  $NestedModules = Get-ChildItem -Attributes Directory |ForEach-Object {if(Get-Item "$($_.FullName)\$($_.Name).psd1"){Write-Output "$($_.Basename)\$($_.BaseName).psd1"}}
  Update-ModuleManifest -Path .\AzDevOps.psd1 -NestedModules $NestedModules
  Update-ModuleManifest -Path .\AzDevOps.psd1 -ModuleList $NestedModules
  Update-ModuleManifest -Path .\AzDevOps.psd1 -FunctionsToExport '*'
}

Task UpdateReadme {
  $moduleName = Get-Item . | ForEach-Object BaseName
  if ($moduleName -eq 'Staging') {$moduleName = 'AzDevOps'}
  $readMe = Get-Item README.md

  if (!(Get-Module -Name $moduleName )) {Import-Module -Name ".\$($moduleName).psd1" }

  Write-Output "| Latest Version | Azure Pipelines | Test Status |" |Out-File $readMe.FullName -Force 
  Write-Output "|-----------------|-----------------|----------------|" |Out-File $readMe.FullName -Append
  Write-Output "![Latest Version](https://img.shields.io/github/v/tag/Azure-Devops-PowerShell-Module/AzDevOps) | ![Azure Pipelines Build Status](https://img.shields.io/azure-devops/build/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/5) | ![Azure Build Test Results](https://img.shields.io/azure-devops/tests/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/5)" |Out-File $readMe.FullName -Append 
  Write-Output "" |Out-File $readMe.FullName -Append
  Write-Output (Invoke-WebRequest -UseBasicParsing -Uri https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/wiki/Home.md |Select-Object -ExpandProperty Content) |Out-File $readMe.FullName -Append
  Write-Output "" |Out-File $readMe.FullName -Append
  Get-Command -Module $moduleName |Sort-Object -Property Noun,Verb |ForEach-Object {Write-Output "## [$($_.Name)](docs/$($_.Name).md)";Write-Output '```';Get-Help $_.Name;Write-Output '```'} |Out-File $readMe.FullName -Append
}