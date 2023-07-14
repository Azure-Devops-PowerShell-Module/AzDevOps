| Latest Version | PowerShell Gallery | Issues | License | Discord |
|-----------------|----------------|----------------|----------------|----------------|
| [![Latest Version](https://img.shields.io/github/v/tag/Azure-Devops-PowerShell-Module/AzDevOps)](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/tags) | [![Powershell Gallery](https://img.shields.io/powershellgallery/dt/AzDevOps)](https://www.powershellgallery.com/packages/AzDevOps) | [![GitHub issues](https://img.shields.io/github/issues/Azure-Devops-PowerShell-Module/AzDevOps)](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues) | [![GitHub license](https://img.shields.io/github/license/Azure-Devops-PowerShell-Module/AzDevOps)](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/LICENSE) | [![Discord Server](https://assets-global.website-files.com/6257adef93867e50d84d30e2/636e0b5493894cf60b300587_full_logo_white_RGB.svg)]() |
# About

The AzDevOps project is designed to leverage the [Azure Devops Rest API](https://docs.microsoft.com/en-us/rest/api/azure/devops) through the use of PowerShell. Currently the modules are all written in PowerShell which should make the code easier to understand and modify as needed. The project will use [Semantic Versioning](https://semver.org/) for modules, these version numbers should also be reflected in the tags.

## Building

The AzDevOps module is composed of multiple nested modules, each module represents a specific set of APIs that are available. Each of these modules is a self-contained repository within the project and should have the same look and feel throughout. Several tools are leveraged to facilitate keeping things as uniform as possible and we will outline them below.

### Documentation

This project uses [PlatyPS](https://github.com/PowerShell/platyPS) for framing and updating the help files and external help used by the functions.

### Automation

A few things within each module are automated by [psake](https://github.com/psake/psake) such as the functions that are exported, as well as the README file for each module.

### Syntax Checking

[PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) is used to check the code against a set of [standards](https://github.com/PowerShell/PSScriptAnalyzer/blob/master/RuleDocumentation/README.md), this ensures that the code works as expected when ran.

### Testing

This is currently a work in progress, but we should be leveraging [pester](https://github.com/pester/Pester) in a future update as well as the [PowerShellBuild Module](https://github.com/psake/PowerShellBuild). Additionally we will be leveraging [Azure Pipelines](https://docs.microsoft.com/en-us/azure/devops/pipelines/?view=azure-devops) to validate versions of [PowerShell](https://github.com/PowerShell/PowerShell) and OS compatability.

## Publishing

The module will be available directly from [GitHub](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps), we are looking to create Tagged releases that are easy to download. Additionally the code will be available on the [PowerShell Gallery](https://www.powershellgallery.com/) for a more streamlined delivery.
# AzDevOps Module

## Description

This module provides the ability to manage and work with an Azure Devops organization.

## AzDevOps Cmdlets

### [Connect-AdoOrganization](Docs/Connect-AdoOrganization.md)

This function will connect to Azure DevOps

### [Get-AdoBuild](Docs/Get-AdoBuild.md)

Return one or more builds from a project

### [Get-AdoBuildDefinition](Docs/Get-AdoBuildDefinition.md)

Gets a definition, optionally at a specific revision.

### [Get-AdoBuildFolder](Docs/Get-AdoBuildFolder.md)

Gets a list of build definition folders

### [Get-AdoBuildLog](Docs/Get-AdoBuildLog.md)

Gets the logs for a build

### [Get-AdoOperation](Docs/Get-AdoOperation.md)

Gets an operation from the the operationId using the given pluginId.

### [Get-AdoProcess](Docs/Get-AdoProcess.md)

Get one or more available processes

### [Get-AdoProject](Docs/Get-AdoProject.md)

Get one or many projects from Azure DevOps

### [Get-AdoProjectProperty](Docs/Get-AdoProjectProperty.md)

Get a collection of team project Property

### [Get-AdoTeam](Docs/Get-AdoTeam.md)

Get a specific team

### [Get-AdoTeamMember](Docs/Get-AdoTeamMember.md)

Get a list of members for a specific team.

### [Invoke-AdoEndpoint](Docs/Invoke-AdoEndpoint.md)

Query Azure Devops

### [New-AdoBuildFolder](Docs/New-AdoBuildFolder.md)

Creates a new folder

### [New-AdoProject](Docs/New-AdoProject.md)

Queues a project to be created

### [New-AdoTeam](Docs/New-AdoTeam.md)

Create a team in a team project

### [Remove-AdoBuild](Docs/Remove-AdoBuild.md)

Deletes a build

### [Remove-AdoBuildFolder](Docs/Remove-AdoBuildFolder.md)

Deletes a definition folder

### [Remove-AdoProject](Docs/Remove-AdoProject.md)

Queues a project to be deleted

### [Remove-AdoTeam](Docs/Remove-AdoTeam.md)

Delete a team.

### [Start-AdoBuild](Docs/Start-AdoBuild.md)

Queues a build

### [Update-AdoProject](Docs/Update-AdoProject.md)

Update Name, Description or Abbreviation of a project

### [Update-AdoTeam](Docs/Update-AdoTeam.md)

Update a team's name and/or description

