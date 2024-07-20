---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildFolder.md#get-qdobuildfolder
schema: 2.0.0
---

# Get-AdoBuildFolder

## SYNOPSIS

Gets a list of build definition folders

## SYNTAX

### Project

```powershell
Get-AdoBuildFolder [-Project <Object>] [-Path <String>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoBuildFolder [-ProjectId <Guid>] [-Path <String>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Gets a list of build definition folders

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoBuildFolder -Project $Project

path      : \
createdOn : 4/8/2020 2:46:31 PM
project   : @{id=c31a2770-9aee-4799-a078-eee0dc12cbf4; name=AzDevOps; description=A project for working with Azure Devops using PowerShell;
            url=https://dev.azure.com/patton-tech/_apis/projects/c31a2770-9aee-4799-a078-eee0dc12cbf4; state=wellFormed; revision=515330752; visibility=public; lastUpdateTime=4/10/2020 4:22:12 AM}
```

Gets a list of build definition folders

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

### -Path

The path to start with

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

The project Id

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildFolder.md#get-Adobuildfolder](https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildFolder.md#get-adobuildfolder)
