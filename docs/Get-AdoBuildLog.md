---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildLog.md#get-adobuildlog
schema: 2.0.0
---

# Get-AdoBuildLog

## SYNOPSIS

Gets the logs for a build

## SYNTAX

### Project

```powershell
Get-AdoBuildLog -Project <Object> -Build <Object> [-LogId <Int32>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoBuildLog -ProjectId <Guid> -BuildId <Int32> [-LogId <Int32>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Gets the logs for a build or an individual log file for a build.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoBuildLog -Project $Project -Build $Build

lineCount     : 58
createdOn     : 8/10/2020 10:46:27 PM
lastChangedOn : 8/10/2020 10:46:27 PM
id            : 1
type          : Container
url           : https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/builds/195/logs/1

lineCount     : 92
createdOn     : 8/10/2020 10:46:27 PM
lastChangedOn : 8/10/2020 10:46:27 PM
id            : 2
type          : Container
url           : https://dev.azure.com/patton-tech/c31a2770-9aee-4799-a078-eee0dc12cbf4/_apis/build/builds/195/logs/2
```

Get the logs for a build

### Example 2

```powershell
PS C:\> Get-AdoBuildLog -Project $Project -Build $Build -LogId 13
2020-08-10T22:47:03.9832097Z ##[section]Starting: nuGet Specfile Creation
2020-08-10T22:47:05.2279046Z ##[section]Starting: Initialize job
2020-08-10T22:47:05.2281860Z Agent name: 'Hosted Agent'
2020-08-10T22:47:05.2282550Z Agent machine name: 'WIN-RS56T8BI7LR'
2020-08-10T22:47:05.2282978Z Current agent version: '2.173.0'
2020-08-10T22:47:05.2313571Z Current image version: '20200802.1'
2020-08-10T22:47:05.2322457Z Agent running as: 'VssAdministrator'
2020-08-10T22:47:05.2701678Z Prepare build directory.
2020-08-10T22:47:05.5072173Z Set build variables.
```

Get the individual log file for a build.

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.2, 7.2-preview.2

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Build

The build

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

### -BuildId

The build id

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

### -LogId

The log id

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

The project

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

The project id

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildLog.md#get-adobuildlog](https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildLog.md#get-adobuildlog)
