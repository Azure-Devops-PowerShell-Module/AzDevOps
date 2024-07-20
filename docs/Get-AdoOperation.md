---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AdoOperation.md#get-adoopsoperation
schema: 2.0.0
---

# Get-AdoOperation

## SYNOPSIS

Gets an operation from the the operationId using the given pluginId.

## SYNTAX

```powershell
Get-AdoOperation [-OperationId] <Guid> [[-ApiVersion] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

Operations provide a way to monitor the process of an async task. This function gets an operation from the the operationId using the given pluginId. Some scenarios don't require a pluginId. If a pluginId is not included in the call then just the operationId will be used to find an operation.

EXAMPLES

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoOperations -OperationId 'c92521c2-5599-4a87-aec6-58afe7b14444'

id                                   status    url                                                                               _links
--                                   ------    ---                                                                               ------
c92521c2-5599-4a87-aec6-58afe7b14444 succeeded https://dev.azure.com/patton-tech/_apis/operations/c92521c2-5599-4a87-aec6-58afe7b14444 @{self=}
```

Get the status of a running operation

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

### -OperationId

This is a GUID that is returned from some Post/Patch/Delete method

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases:

Required: True
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
