---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/New-AdoBuildFolder.md#new-adobuildfolder
schema: 2.0.0
---

# New-AdoBuildFolder

## SYNOPSIS

Creates a new folder

## SYNTAX

### Project

```powershell
New-AdoBuildFolder [-Project <Object>] -Name <String> [-Description <String>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ProjectId

```powershell
New-AdoBuildFolder [-ProjectId <Guid>] -Name <String> [-Description <String>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Creates a new folder

## EXAMPLES

### Example 1

```powershell
PS C:\> New-AdoBuildFolder -Project $Project -Name TestFolder -Description 'A Folder for testing'

path        : \TestFolder
description : A Folder for testing
createdOn   : 1/13/2023 8:05:55 PM
createdBy   : @{displayName=Jeffrey Patton; url=https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797; _links=;
              id=636851f0-e884-48a4-962e-f1d1bcc29797; uniqueName=jeffrey@patton-tech.com;
              imageUrl=https://dev.azure.com/patton-tech/_apis/GraphProfile/MemberAvatars/aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0; descriptor=aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0}
project     : @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell;
              url=https://dev.azure.com/patton-tech/_apis/projects/c31a2770-9aee-4799-a078-eee0dc12cbf4; state=wellFormed; revision=515330752; visibility=public; lastUpdateTime=4/10/2020 4:22:12 AM}
```

Creating a folder

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1-preview.2, 7.1-preview.2, 7.2-preview.2

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

The description

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The full path of the folder

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

The project

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

The Project Id

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

[https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/New-AdoBuildFolder.md#new-adobuildfolder](https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/New-AdoBuildFolder.md#new-adobuildfolder)
