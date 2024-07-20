---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-adoBuildFolder.md#remove-Adobuildfolder
schema: 2.0.0
---

# Remove-AdoBuildFolder

## SYNOPSIS

Deletes a definition folder

## SYNTAX

### Project

```powershell
Remove-AdoBuildFolder [-Project <Object>] -Name <String> [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ProjectId

```powershell
Remove-AdoBuildFolder [-ProjectId <Guid>] -Name <String> [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Deletes a definition folder. Definitions and their corresponding builds will
also be deleted.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-AdoBuildFolder -Project $Project -Name TestFolder

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove Folder TestFolder from AzDevOps Azure Devops Projects" on target "Delete".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y


path createdOn           project
---- ---------           -------
\    4/8/2020 2:46:31 PM @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell; url=https://dev.azure.com/patton-tech/_apis/projects/c…
```

Remove a folder

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.0-preview.2, 7.1-preview.2, 7.2-preview.2

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Name of the folder

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

Project

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

Project Id

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

### System.String

## NOTES

## RELATED LINKS

[https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AdoBuildFolder.md#remove-adobuildfolder](https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AdoBuildFolder.md#remove-adobuildfolder)
