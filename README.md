| Latest Version | Azure Pipelines | Test Status | PowerShell Gallery | Github Release |
|-----------------|-----------------|----------------|----------------|----------------|
![Latest Version](https://img.shields.io/github/v/tag/Azure-Devops-PowerShell-Module/AzDevOps) | ![Azure Pipelines Build Status](https://img.shields.io/azure-devops/build/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/5) | ![Azure Build Test Results](https://img.shields.io/azure-devops/tests/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/5) | ![Powershell Gallery](https://img.shields.io/powershellgallery/dt/AzDevOps) | ![Github Release](https://img.shields.io/github/downloads/Azure-Devops-PowerShell-Module/AzDevOps/total)

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

## [Get-AzDevOpsOperation](docs/Get-AzDevOpsOperation.md)
```

NAME
    Get-AzDevOpsOperation
    
SYNTAX
    Get-AzDevOpsOperation [-OperationId] <guid>  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-AzDevOpsOperation -Online" or 
           go to https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsOperation.md#get-a
    zdevopsoperation.

```
## [Connect-AzDevOpsOrganization](docs/Connect-AzDevOpsOrganization.md)
```

examples      : @{example=@{code=PS C:\> Connect-AzDevOps -Orgname patton-tech -PAT **********
                
                Connected to https://dev.azure.com/patton-tech/; remarks=System.Management.Automation.PSObject[]; 
                title=-------------------------- Example 1 --------------------------}}
inputTypes    : @{inputType=@{type=@{name=None}; description=System.Management.Automation.PSObject[]}}
alertSet      : @{alert=System.Management.Automation.PSObject[]}
syntax        : @{syntaxItem=@{name=Connect-AzDevOpsOrganization; parameter=System.Management.Automation.PSObject[]}}
parameters    : @{parameter=System.Management.Automation.PSObject[]}
details       : @{description=System.Management.Automation.PSObject[]; verb=Connect; noun=AzDevOpsOrganization; 
                name=Connect-AzDevOpsOrganization}
description   : {@{Text=This function will connect to Azure Devops, you will need to provide a valid Organization Name 
                 and you must have created a Personal Access Token}}
relatedLinks  : @{navigationLink=@{uri=https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-
                AzDevOpsOrganization.md#connect-azdevopsOrganization; linkText=Online Version:}}
returnValues  : @{returnValue=@{type=@{name=System.Object}; description=System.Management.Automation.PSObject[]}}
xmlns:maml    : http://schemas.microsoft.com/maml/2004/10
xmlns:command : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev     : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:MSHelp  : http://msdn.microsoft.com/mshelp
Name          : Connect-AzDevOpsOrganization
Category      : Function
Synopsis      : This function will connect to Azure DevOps
Component     : 
Role          : 
Functionality : 
ModuleName    : AzDevOps

```
## [Get-AzDevOpsProcess](docs/Get-AzDevOpsProcess.md)
```
NAME
    Get-AzDevOpsProcess
    
SYNTAX
    Get-AzDevOpsProcess [[-ProcessId] <guid>]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-AzDevOpsProcess -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsProcess.md#get-azdevopsprocess.

```
## [Get-AzDevOpsProject](docs/Get-AzDevOpsProject.md)
```
NAME
    Get-AzDevOpsProject
    
SYNTAX
    Get-AzDevOpsProject [[-ProjectId] <guid>]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-AzDevOpsProject -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsProject.md#get-azdevopsproject.

```
## [New-AzDevOpsProject](docs/New-AzDevOpsProject.md)
```
NAME
    New-AzDevOpsProject
    
SYNTAX
    New-AzDevOpsProject [-Name] <string> [[-Description] <string>] [-WhatIf] [-Confirm]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help New-AzDevOpsProject -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/New-AzDevOpsProject.md#new-azdevopsproject.

```
## [Remove-AzDevOpsProject](docs/Remove-AzDevOpsProject.md)
```
NAME
    Remove-AzDevOpsProject
    
SYNTAX
    Remove-AzDevOpsProject [-Project] <Object> [-WhatIf] [-Confirm]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Remove-AzDevOpsProject -Online" or 
           go to https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Remove-AzDevOpsProject.md#remo
    ve-azdevopsproject.

```
## [Update-AzDevOpsProject](docs/Update-AzDevOpsProject.md)
```
NAME
    Update-AzDevOpsProject
    
SYNTAX
    Update-AzDevOpsProject [[-Name] <string>] [[-Description] <string>] [[-Abbreviation] <string>] [[-Project] 
    <Object>] [-WhatIf] [-Confirm]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Update-AzDevOpsProject -Online" or 
           go to https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Update-AzDevOpsProject.md#upda
    te-azdevopsproject.

```
## [Get-AzDevOpsProjectProperty](docs/Get-AzDevOpsProjectProperty.md)
```
NAME
    Get-AzDevOpsProjectProperty
    
SYNTAX
    Get-AzDevOpsProjectProperty [[-Project] <Object>]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-AzDevOpsProjectProperty -Online" or 
           go to https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsProjectProperty.md
    #get-azdevopsprojectproperty.

```
## [Get-AzDevOpsTeam](docs/Get-AzDevOpsTeam.md)
```
NAME
    Get-AzDevOpsTeam
    
SYNTAX
    Get-AzDevOpsTeam [-Project <Object>] [-TeamId <guid>]  [<CommonParameters>]
    
    Get-AzDevOpsTeam [-ProjectId <guid>] [-TeamId <guid>]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-AzDevOpsTeam -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsTeam.md#get-azdevopsteam.

```
## [New-AzDevOpsTeam](docs/New-AzDevOpsTeam.md)
```
NAME
    New-AzDevOpsTeam
    
SYNTAX
    New-AzDevOpsTeam [-Name] <string> [[-Description] <string>] [[-Project] <Object>] [-WhatIf] [-Confirm]  
    [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help New-AzDevOpsTeam -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/New-AzDevOpsTeam.md#new-azdevopsteam.

```
## [Remove-AzDevOpsTeam](docs/Remove-AzDevOpsTeam.md)
```
NAME
    Remove-AzDevOpsTeam
    
SYNTAX
    Remove-AzDevOpsTeam [-ProjectId] <guid> [-TeamId] <guid> [-WhatIf] [-Confirm]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Remove-AzDevOpsTeam -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Remove-AzDevOpsTeam.md#remove-azdevopsteam.

```
## [Update-AzDevOpsTeam](docs/Update-AzDevOpsTeam.md)
```
NAME
    Update-AzDevOpsTeam
    
SYNTAX
    Update-AzDevOpsTeam [[-Name] <string>] [[-Description] <string>] [[-Team] <Object>] [-WhatIf] [-Confirm]  
    [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Update-AzDevOpsTeam -Online" or 
           go to 
    https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Update-AzDevOpsTeam.md#update-azdevopsteam.

```
## [Get-AzDevOpsTeamMember](docs/Get-AzDevOpsTeamMember.md)
```
NAME
    Get-AzDevOpsTeamMember
    
SYNTAX
    Get-AzDevOpsTeamMember [-Project <Object>] [-TeamId <guid>]  [<CommonParameters>]
    
    Get-AzDevOpsTeamMember [-ProjectId <guid>] [-TeamId <guid>]  [<CommonParameters>]
    

ALIASES
    None
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-AzDevOpsTeamMember -Online" or 
           go to https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsTeamMember.md#get-
    azdevopsteammember.

```


