---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Remove-AdoProject.md#remove-adoproject
schema: 2.0.0
---

# Remove-AdoProject

## SYNOPSIS

Queues a project to be deleted

## SYNTAX

```powershell
Remove-AdoProject [-Project] <Object> [[-ApiVersion] <String>] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

A function to easily remove a project from Azure Devops

## EXAMPLES

### Example 1

```powershell
PS C:\> $Project = Get-AdoProject 4027d479-6afb-4201-9646-c580bf8d7251

$Project


id             : 4027d479-6afb-4201-9646-c580bf8d7251
name           : newproject
description    : this is a new project
url            : https://dev.azure.com/patton-tech/_apis/projects/4027d479-6afb-4201-9646-c580bf8d7251
state          : wellFormed
revision       : 515330653
_links         : @{self=; collection=; web=}
visibility     : private
defaultTeam    : @{id=25008b15-01a6-4b27-a9f9-5872e2713b87; name=newproject Team; url=https://dev.azure.com/patton-tech/_apis/projects/4027d479-6afb-4201-9646-c580bf8d7251/teams/25008b15-01a6-4b27-a9f9-5872e2713b87}
lastUpdateTime : 2020-04-08T19:28:13.077Z

Remove-AdoProject -Project $Project

id                                   status url
--                                   ------ ---
1569ba20-7ed2-4ff0-8c1f-412bbcc3700d notSet https://dev.azure.com/patton-tech/_apis/operations/1569ba20-7ed2-4ff0-8c1f-412bbcc3700d
```

Deleting a project

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.4, 7.2-preview.4

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction

{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Project

This is a project as returned from Get-AdoProject

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Connect-AdoOrganization](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-adoOrganization.md#connect-Adoorganization)

[Get-AdoOperation](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-adoOrganization.md#get-Adooperation)

[Get-AdoProject](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#get-adoproject)
