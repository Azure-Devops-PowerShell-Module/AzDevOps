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
    
SYNOPSIS
    Gets an operation from the the operationId using the given pluginId.
    
    
SYNTAX
    Get-AzDevOpsOperation [-OperationId] <Guid> [<CommonParameters>]
    
    
DESCRIPTION
    Operations provide a way to monitor the process of an async task. This function gets an operation from the the 
    operationId using the given pluginId. Some scenarios don't require a pluginId. If a pluginId is not included in 
    the call then just the operationId will be used to find an operation.
    
    https://docs.microsoft.com/en-us/rest/api/azure/devops/operations/operations?view=azure-devops-rest-5.1
    

RELATED LINKS
    Online Version: https://github.com/Azure-Devops-PowerShell-Module/operations/blob/master/docs/Get-AzDevOpsOperation
    .md#get-azdevopsoperation
    Connect-AzDevOpsOrganization https://github.com/Azure-Devops-PowerShell-Module/authentication/blob/master/docs/Conn
    ect-AzDevOpsOrganization.md#connect-azdevopsorganization

REMARKS
    To see the examples, type: "get-help Get-AzDevOpsOperation -examples".
    For more information, type: "get-help Get-AzDevOpsOperation -detailed".
    For technical information, type: "get-help Get-AzDevOpsOperation -full".
    For online help, type: "get-help Get-AzDevOpsOperation -online"
```
## [Connect-AzDevOpsOrganization](docs/Connect-AzDevOpsOrganization.md)
```
NAME
    Connect-AzDevOpsOrganization
    
SYNOPSIS
    This function will connect to Azure DevOps
    
    
SYNTAX
    Connect-AzDevOpsOrganization [-Orgname] <String> [-PAT] <String> [<CommonParameters>]
    
    
DESCRIPTION
    This function will connect to Azure Devops, you will need to provide a valid Organization Name  and you must have 
    created a Personal Access Token
    

RELATED LINKS

REMARKS
    To see the examples, type: "get-help Connect-AzDevOpsOrganization -examples".
    For more information, type: "get-help Connect-AzDevOpsOrganization -detailed".
    For technical information, type: "get-help Connect-AzDevOpsOrganization -full".

```
## [Get-AzDevOpsProcess](docs/Get-AzDevOpsProcess.md)
```
NAME
    Get-AzDevOpsProcess
    
SYNOPSIS
    Get one or more available processes
    
    
SYNTAX
    Get-AzDevOpsProcess [[-ProcessId] <Guid>] [<CommonParameters>]
    
    
DESCRIPTION
    This function will return one or more Processes from Azure DevOps.
    

RELATED LINKS
    Online Version: https://github.com/Azure-Devops-PowerShell-Module/processes/blob/master/docs/Get-AzDevOpsProcess.md
    #get-azdevopsprocess
    Connect-AzDevOpsOrganization https://github.com/Azure-Devops-PowerShell-Module/authentication/blob/master/docs/Conn
    ect-AzDevOpsOrganization.md#connect-azdevopsorganization

REMARKS
    To see the examples, type: "get-help Get-AzDevOpsProcess -examples".
    For more information, type: "get-help Get-AzDevOpsProcess -detailed".
    For technical information, type: "get-help Get-AzDevOpsProcess -full".
    For online help, type: "get-help Get-AzDevOpsProcess -online"
```
## [Get-AzDevOpsProject](docs/Get-AzDevOpsProject.md)
```
NAME
    Get-AzDevOpsProject
    
SYNOPSIS
    Get one or many projects from Azure DevOps
    
    
SYNTAX
    Get-AzDevOpsProject [[-ProjectId] <Guid>] [<CommonParameters>]
    
    
DESCRIPTION
    Get project with the specified id or name, optionally including capabilities.
    

RELATED LINKS
    Connect-AzDevOpsOrganization https://github.com/Azure-Devops-PowerShell-Module/authentication/blob/master/docs/Conn
    ect-AzDevOpsOrganization.md#connect-azdevopsorganization

REMARKS
    To see the examples, type: "get-help Get-AzDevOpsProject -examples".
    For more information, type: "get-help Get-AzDevOpsProject -detailed".
    For technical information, type: "get-help Get-AzDevOpsProject -full".
    For online help, type: "get-help Get-AzDevOpsProject -online"
```
## [New-AzDevOpsProject](docs/New-AzDevOpsProject.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=New-AzDevOpsProject; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help New-AzDevOpsProject 
                           -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/New
                           -AzDevOpsProject.md#new-azdevopsproject.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           New-AzDevOpsProject [-Name] <string> [[-Description] <string>] [-WhatIf] [-Confirm] 
                           [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : New-AzDevOpsProject
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```
## [Remove-AzDevOpsProject](docs/Remove-AzDevOpsProject.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=Remove-AzDevOpsProject; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help 
                           Remove-AzDevOpsProject -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Rem
                           ove-AzDevOpsProject.md#remove-azdevopsproject.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           Remove-AzDevOpsProject [-Project] <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : Remove-AzDevOpsProject
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```
## [Get-AzDevOpsProjectProperty](docs/Get-AzDevOpsProjectProperty.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=Get-AzDevOpsProjectProperty; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help 
                           Get-AzDevOpsProjectProperty -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get
                           -AzDevOpsProjectProperty.md#get-azdevopsprojectproperty.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           Get-AzDevOpsProjectProperty [[-Project] <Object>] [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : Get-AzDevOpsProjectProperty
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```
## [Get-AzDevOpsTeam](docs/Get-AzDevOpsTeam.md)
```
NAME
    Get-AzDevOpsTeam
    
SYNOPSIS
    Get a specific team
    
    
SYNTAX
    Get-AzDevOpsTeam [-Project <Object>] [-TeamId <Guid>] [<CommonParameters>]
    
    Get-AzDevOpsTeam [-ProjectId <Guid>] [-TeamId <Guid>] [<CommonParameters>]
    
    
DESCRIPTION
    This function will return a specific team, or all teams in a given project
    

RELATED LINKS
    Online Version: 
    https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AzDevOpsTeam.md#get-azdevopsteam
    Connect-AzDevOpsOrganization https://github.com/Azure-Devops-PowerShell-Module/authentication/blob/master/docs/Conn
    ect-AzDevOpsOrganization.md#connect-azdevopsorganization

REMARKS
    To see the examples, type: "get-help Get-AzDevOpsTeam -examples".
    For more information, type: "get-help Get-AzDevOpsTeam -detailed".
    For technical information, type: "get-help Get-AzDevOpsTeam -full".
    For online help, type: "get-help Get-AzDevOpsTeam -online"
```
## [New-AzDevOpsTeam](docs/New-AzDevOpsTeam.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=New-AzDevOpsTeam; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help New-AzDevOpsTeam 
                           -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/New-Az
                           DevOpsTeam.md#new-azdevopsteam.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           New-AzDevOpsTeam [-Name] <string> [[-Description] <string>] [[-Project] <Object>] [-WhatIf] 
                           [-Confirm] [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : New-AzDevOpsTeam
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```
## [Remove-AzDevOpsTeam](docs/Remove-AzDevOpsTeam.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=Remove-AzDevOpsTeam; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help Remove-AzDevOpsTeam 
                           -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Remove
                           -AzDevOpsTeam.md#remove-azdevopsteam.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           Remove-AzDevOpsTeam [-ProjectId] <guid> [-TeamId] <guid> [-WhatIf] [-Confirm] 
                           [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : Remove-AzDevOpsTeam
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```
## [Update-AzDevOpsTeam](docs/Update-AzDevOpsTeam.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=Update-AzDevOpsTeam; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help Update-AzDevOpsTeam 
                           -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Update
                           -AzDevOpsTeam.md#update-azdevopsteam.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           Update-AzDevOpsTeam [[-Name] <string>] [[-Description] <string>] [[-Team] <Object>] 
                           [-WhatIf] [-Confirm] [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : Update-AzDevOpsTeam
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```
## [Get-AzDevOpsTeamMember](docs/Get-AzDevOpsTeamMember.md)
```

CommonParameters         : True
WorkflowCommonParameters : False
details                  : @{name=Get-AzDevOpsTeamMember; noun=; verb=}
Syntax                   : @{syntaxItem=System.Object[]}
parameters               : @{parameter=System.Object[]}
inputTypes               : @{inputType=}
relatedLinks             : @{navigationLink=System.Management.Automation.PSObject[]}
returnValues             : @{returnValue=}
aliases                  : None
                           
remarks                  : Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only 
                           partial help.
                               -- To download and install Help files for the module that includes this cmdlet, use 
                           Update-Help.
                               -- To view the Help topic for this cmdlet online, type: "Get-Help 
                           Get-AzDevOpsTeamMember -Online" or 
                                  go to https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-Az
                           DevOpsTeamMember.md#get-azdevopsteammember.
alertSet                 : 
description              : 
examples                 : 
Synopsis                 : 
                           Get-AzDevOpsTeamMember [-Project <Object>] [-TeamId <guid>] [<CommonParameters>]
                           
                           Get-AzDevOpsTeamMember [-ProjectId <guid>] [-TeamId <guid>] [<CommonParameters>]
                           
ModuleName               : AzDevOps
nonTerminatingErrors     : 
xmlns:command            : http://schemas.microsoft.com/maml/dev/command/2004/10
xmlns:dev                : http://schemas.microsoft.com/maml/dev/2004/10
xmlns:maml               : http://schemas.microsoft.com/maml/2004/10
Name                     : Get-AzDevOpsTeamMember
Category                 : Function
Component                : 
Role                     : 
Functionality            : 

```


