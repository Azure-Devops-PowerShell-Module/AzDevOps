---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Start-AdoBuild.md#start-adobuild
schema: 2.0.0
---

# Start-AdoBuild

## SYNOPSIS

Queues a build

## SYNTAX

### Project

```powershell
Start-AdoBuild -Project <Object> -Definition <Object> [-Variables <Hashtable[]>] [-Wait] [-ApiVersion <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ProjectId

```powershell
Start-AdoBuild -ProjectId <Guid> -DefinitionId <Int32> [-Variables <Hashtable[]>] [-Wait]
 [-ApiVersion <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Queues a build

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-AdoBuild -Project $Project -Definition $Build.definition

_links                       : @{self=; web=; sourceVersionDisplayUri=; timeline=; badge=}
properties                   :
tags                         : {}
validationResults            : {@{result=error; message=The pipeline is not valid. Could not get the latest source version for repository Azure-Devops-PowerShell-Module/tools hosted on https://github.com/
                               using ref refs/heads/master. GitHub reported the error, "Bad credentials" Could not get the latest source version for repository Azure-Devops-PowerShell-Module/core hosted on
                               https://github.com/ using ref refs/heads/master. GitHub reported the error, "Bad credentials"}}
plans                        : {@{planId=32704126-06c4-446e-b992-abd3dc3f5bc4}}
triggerInfo                  :
id                           : 284
buildNumber                  : 20230113.1
status                       : completed
result                       : failed
queueTime                    : 1/13/2023 8:42:33 PM
startTime                    : 1/13/2023 8:42:33 PM
finishTime                   : 1/13/2023 8:42:33 PM
url                          : https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/Builds/284
definition                   : @{drafts=System.Object[]; id=8; name=AzDevOps.git; url=https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/Definitions/8?revision=1;
                               uri=vstfs:///Build/Definition/8; path=\; type=build; queueStatus=enabled; revision=1; project=}
buildNumberRevision          : 1
project                      : @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell;
                               url=https://dev.azure.com/patton-tech/_apis/projects/c31a2770-9aee-4799-a078-eee0dc12cbf4; state=wellFormed; revision=515330752; visibility=public; lastUpdateTime=4/10/2020
                               4:22:12 AM}
uri                          : vstfs:///Build/Build/284
sourceBranch                 : refs/heads/master
sourceVersion                : d7d533a3fdc2d1a80350c906942e10cc32761158
queue                        : @{id=135; name=Azure Pipelines; pool=}
priority                     : normal
reason                       : manual
requestedFor                 : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797;
                               _links=; id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
                               imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0;
                               descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
requestedBy                  : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797;
                               _links=; id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
                               imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0;
                               descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
lastChangedDate              : 1/13/2023 8:42:33 PM
lastChangedBy                : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797;
                               _links=; id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
                               imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0;
                               descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
parameters                   : {}
orchestrationPlan            : @{planId=32704126-06c4-446e-b992-abd3dc3f5bc4}
logs                         : @{id=0; type=Container; url=https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/builds/284/logs}
repository                   : @{id=6df1297d-eb7b-41df-bec0-c670d3bb7be4; type=TfsGit; name=AzDevOps.git; url=https://dev.azure.com/patton-tech/AzDevOps/_git/AzDevOps.git; clean=; checkoutSubmodules=False}
retainedByRelease            : False
triggeredByBuild             :
appendCommitMessageToRunName : True
```

Queue up a build

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.7

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Definition

Definition to queue

```yaml
Type: System.Object
Parameter Sets: Project
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DefinitionId

Definition Id

```yaml
Type: System.Int32
Parameter Sets: ProjectId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Project

Project

```yaml
Type: System.Object
Parameter Sets: Project
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProjectId

Project Id

```yaml
Type: System.Guid
Parameter Sets: ProjectId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variables

Variables to pass

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait

Wait for job to complete

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

[https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Start-AdoBuild.md#start-adobuild](https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Start-AdoBuild.md#start-adobuild)
