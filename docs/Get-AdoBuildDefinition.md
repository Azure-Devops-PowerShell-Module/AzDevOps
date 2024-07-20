---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildDefinition.md#get-adobuilddefinition
schema: 2.0.0
---

# Get-AdoBuildDefinition

## SYNOPSIS

Gets a definition, optionally at a specific revision.

## SYNTAX

### Project

```powershell
Get-AdoBuildDefinition [-Project <Object>] [-DefinitionId <Int32>] [-Revision <Int32>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoBuildDefinition [-ProjectId <Guid>] [-DefinitionId <Int32>] [-Revision <Int32>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This allows you to pull a list of definitions from a project, a given defintion
from a build or a specific revision of a definition

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoBuildDefinition -Project $Project

_links      : @{self=; web=; editor=; badge=}
quality     : definition
authoredBy  : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797; _links=;
              id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
              imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0; descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
drafts      : {}
queue       : @{_links=; id=135; name=Azure Pipelines; url=https://dev.azure.com/patton-tech/_apis/build/Queues/135; pool=}
id          : 5
name        : Azure-Devops-PowerShell-Module.AzDevOps
url         : https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/Definitions/5?revision=88
uri         : vstfs:///Build/Definition/5
path        : \
type        : build
queueStatus : enabled
revision    : 88
createdDate : 4/15/2020 4:05:31 PM
project     : @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell;
              url=https://dev.azure.com/patton-tech/_apis/projects/c31a2770-9aee-4799-a078-eee0dc12cbf4; state=wellFormed; revision=515330752; visibility=public; lastUpdateTime=4/10/2020 4:22:12 AM}
```

Get a list of definitions in the project

### Example 2

```powershell
PS C:\> Get-AdoBuildDefinition -Project $Project -DefinitionId $Build.definition.id

triggers                  : {@{branchFilters=System.Object[]; pathFilters=System.Object[]; settingsSourceType=2; batchChanges=False; maxConcurrentBuildsPerBranch=1; triggerType=continuousIntegration}}
properties                :
tags                      : {}
_links                    : @{self=; web=; editor=; badge=}
jobAuthorizationScope     : projectCollection
jobTimeoutInMinutes       : 60
jobCancelTimeoutInMinutes : 5
badgeEnabled              : True
process                   : @{yamlFilename=azure-pipelines.yml; type=2}
repository                : @{properties=; id=6df1297d-eb7b-41df-bec0-c670d3bb7be4; type=TfsGit; name=AzDevOps.git; url=https://dev.azure.com/patton-tech/AzDevOps/_git/AzDevOps.git;
                            defaultBranch=refs/heads/master; clean=; checkoutSubmodules=False}
quality                   : definition
authoredBy                : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797; _links=;
                            id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
                            imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0;
                            descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
drafts                    : {}
queue                     : @{_links=; id=130; name=Hosted Ubuntu 1604; url=https://dev.azure.com/patton-tech/_apis/build/Queues/130; pool=}
id                        : 8
name                      : AzDevOps.git
url                       : https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/Definitions/8?revision=1
uri                       : vstfs:///Build/Definition/8
path                      : \
type                      : build
queueStatus               : enabled
revision                  : 4
createdDate               : 8/11/2020 8:13:43 AM
project                   : @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell;
                            url=https://dev.azure.com/patton-tech/_apis/projects/c31a2770-9aee-4799-a078-eee0dc12cbf4; state=wellFormed; revision=515330752; visibility=public; lastUpdateTime=4/10/2020
                            4:22:12 AM}
```

Get a particular definition

### Example 3

```powershell
PS C:\> Get-AdoBuildDefinition -Project $Project -DefinitionId $Build.definition.id -Revision 1

triggers                  : {@{branchFilters=System.Object[]; pathFilters=System.Object[]; settingsSourceType=2; batchChanges=False; maxConcurrentBuildsPerBranch=1; triggerType=continuousIntegration}}
properties                :
tags                      : {}
_links                    : @{self=; web=; editor=; badge=}
jobAuthorizationScope     : projectCollection
jobTimeoutInMinutes       : 60
jobCancelTimeoutInMinutes : 5
badgeEnabled              : True
process                   : @{yamlFilename=azure-pipelines.yml; type=2}
repository                : @{properties=; id=6df1297d-eb7b-41df-bec0-c670d3bb7be4; type=TfsGit; name=AzDevOps.git; url=https://dev.azure.com/patton-tech/AzDevOps/_git/AzDevOps.git;
                            defaultBranch=refs/heads/master; clean=; checkoutSubmodules=False}
quality                   : definition
authoredBy                : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797; _links=;
                            id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
                            imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0;
                            descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
drafts                    : {}
queue                     : @{_links=; id=130; name=Hosted Ubuntu 1604; url=https://dev.azure.com/patton-tech/_apis/build/Queues/130; pool=}
id                        : 8
name                      : AzDevOps.git
url                       : https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/Definitions/8?revision=1
uri                       : vstfs:///Build/Definition/8
path                      : \
type                      : build
queueStatus               : enabled
revision                  : 1
createdDate               : 8/10/2020 9:21:31 PM
project                   : @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell;
                            url=https://dev.azure.com/patton-tech/_apis/projects/c31a2770-9aee-4799-a078-eee0dc12cbf4; state=wellFormed; revision=515330752; visibility=public; lastUpdateTime=4/10/2020
                            4:22:12 AM}
```

Get a specific revision of a definition

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.7, 7.2-preview.7

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefinitionId

The ID of a definition

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Project

The project definitions are found in

```yaml
Type: System.Object
Parameter Sets: Project
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProjectId

The project id of a project definitions are found in

```yaml
Type: System.Guid
Parameter Sets: ProjectId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Revision

The revision of a definition

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
