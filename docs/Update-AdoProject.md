---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Update-AdoProject.md#update-adoproject
schema: 2.0.0
---

# Update-AdoProject

## SYNOPSIS

Update Name, Description or Abbreviation of a project

## SYNTAX

```
Update-AdoProject [[-Name] <String>] [[-Description] <String>] [-Project] <Object> [[-ApiVersion] <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function allows you to update the Name or Description or Abbreviation of a
given project within Azure DevOps.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoProject -ProjectId 2e6901c2-7cfb-40ea-901b-dfb439566e13 |Update-AdoProject -Name newproject


id             : 2e6901c2-7cfb-40ea-901b-dfb439566e13
name           : newproject
url            : https://dev.azure.com/patton-tech/_apis/projects/2e6901c2-7cfb-40ea-901b-dfb439566e13
state          : wellFormed
revision       : 515330771
_links         : @{self=; collection=; web=}
visibility     : private
defaultTeam    : @{id=cb24c842-7e32-4438-bf5d-fc67ac28a5c1; name=123abc Team; url=https://dev.azure.com/patton-tech/_apis/projects/2e6901c2-7cfb-40ea-901b-dfb439566e13/teams/cb24c842-7e32-4438-bf5d-fc67ac28a5c1}
lastUpdateTime : 2020-04-14T14:54:32.91Z
```

Changing the name of a project

### Example 2

```powershell
PS C:\> Get-AdoProject -ProjectId 2e6901c2-7cfb-40ea-901b-dfb439566e13 |Update-AdoProject -Name updatedproject -Description 'a new project description'


id             : 2e6901c2-7cfb-40ea-901b-dfb439566e13
name           : updatedproject
description    : a new project description
url            : https://dev.azure.com/patton-tech/_apis/projects/2e6901c2-7cfb-40ea-901b-dfb439566e13
state          : wellFormed
revision       : 515330772
_links         : @{self=; collection=; web=}
visibility     : private
defaultTeam    : @{id=cb24c842-7e32-4438-bf5d-fc67ac28a5c1; name=newproject Team; url=https://dev.azure.com/patton-tech/_apis/projects/2e6901c2-7cfb-40ea-901b-dfb439566e13/teams/cb24c842-7e32-4438-bf5d-fc67ac28a5c1}
```

Changing the name and description of a project

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.4, 7.2-preview.4

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

A descriptive name for the project

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

A name for the project

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

A project object as returned from Get-AdoProject

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

### System.Object

## NOTES

## RELATED LINKS

[Connect-AdoOrganization](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#connect-adoorganization)

[Get-AdoOperation](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#get-adooperation)

[Get-AdoProject](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#get-adoproject)
