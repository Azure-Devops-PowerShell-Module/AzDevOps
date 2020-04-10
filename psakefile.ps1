Task default -depends ModulesToExport

Task ModulesToExport {
  $NestedModules = Get-ChildItem -Attributes Directory |ForEach-Object {if(Get-Item "$($_.FullName)\$($_.Name).psd1"){Write-Output "$($_.Basename)\$($_.BaseName).psd1"}}
  Update-ModuleManifest -Path .\AzDevOps.psd1 -NestedModules $NestedModules
  Update-ModuleManifest -Path .\AzDevOps.psd1 -ModuleList $NestedModules
  Update-ModuleManifest -Path D:\CODE\projects\Azure-Devops-PowerShell-Module\AzDevOps\AzDevOps.psd1 -FunctionsToExport '*'
}

Task UpdateReadme {
  $moduleName = Get-Item . | ForEach-Object BaseName
  $readMe = Get-Item README.md

  if (!(Get-Module -Name $moduleName )) {Import-Module -Name ".\$($moduleName).psd1" }

  Write-Output "[![GitHub issues](https://img.shields.io/github/issues/Azure-Devops-PowerShell-Module/$($moduleName))](https://github.com/Azure-Devops-PowerShell-Module/$($moduleName)/issues)" |Out-File $readMe.FullName -Force 
  Write-Output "[![GitHub forks](https://img.shields.io/github/forks/Azure-Devops-PowerShell-Module/$($moduleName))](https://github.com/Azure-Devops-PowerShell-Module/$($moduleName)/network)" |Out-File $readMe.FullName -Append
  Write-Output "[![GitHub license](https://img.shields.io/github/license/Azure-Devops-PowerShell-Module/$($moduleName))](https://github.com/Azure-Devops-PowerShell-Module/$($moduleName)/blob/master/LICENSE)" |Out-File $readMe.FullName -Append

  Get-Command -Module $moduleName |Sort-Object -Property Noun,Verb |ForEach-Object {Write-Output "## [$($_.Name)](docs/$($_.Name).md)";Write-Output '```';Get-Help $_.Name;Write-Output '```'} |Out-File $readMe.FullName -Append
}