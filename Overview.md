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
