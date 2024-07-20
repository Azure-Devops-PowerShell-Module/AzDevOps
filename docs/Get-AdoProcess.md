---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/processes/blob/master/docs/Get-AdoProcess.md#get-adoprocess
schema: 2.0.0
---

# Get-AdoProcess

## SYNOPSIS

Get one or more available processes

## SYNTAX

```powershell
Get-AdoProcess [[-ProcessId] <Guid>] [[-ApiVersion] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

This function will return one or more Processes from Azure DevOps.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoProcess


id          : 27450541-8e31-4150-9947-dc59f998fc01
description : This template is for more formal projects requiring a framework for process improvement and an auditable record of decisions.
isDefault   : False
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/27450541-8e31-4150-9947-dc59f998fc01
name        : CMMI

id          : 6b724908-ef14-45cf-84f8-768b5384da45
description : This template is for teams who follow the Scrum framework.
isDefault   : False
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/6b724908-ef14-45cf-84f8-768b5384da45
name        : Scrum

id          : adcc42ab-9882-485e-a3ed-7678f01f66bc
description : This template is flexible and will work great for most teams using Agile planning methods, including those practicing Scrum.
isDefault   : True
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/adcc42ab-9882-485e-a3ed-7678f01f66bc
name        : Agile

id          : b8a3a935-7e91-48b8-a94c-606d37c3e9f2
description : This template is flexible for any process and great for teams getting started with Azure DevOps.
isDefault   : False
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/b8a3a935-7e91-48b8-a94c-606d37c3e9f2
name        : Basic
```

Get a list of all processes

### Example 2

```powershell
PS C:\> Get-AdoProcess -ProcessId 27450541-8e31-4150-9947-dc59f998fc01


id          : 27450541-8e31-4150-9947-dc59f998fc01
description : This template is for more formal projects requiring a framework for process improvement and an auditable record of decisions.
isDefault   : False
_links      : @{self=}
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/27450541-8e31-4150-9947-dc59f998fc01
name        : CMMI
```

Get a specific process

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.1, 7.2-preview.1

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessId

The Process ID

```yaml
Type: System.Guid
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
