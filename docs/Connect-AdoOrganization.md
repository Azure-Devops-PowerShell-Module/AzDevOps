---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#connect-adoorganization
schema: 2.0.0
---

# Connect-AdoOrganization

## SYNOPSIS

This function will connect to Azure DevOps

## SYNTAX

```powershell
Connect-AdoOrganization [-Orgname] <String> [-PAT] <String> [[-ApiVersion] <String>] [<CommonParameters>]
```

## DESCRIPTION

This function will connect to Azure Devops, you will need to provide a valid Organization Name
and you must have created a Personal Access Token

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-AdoOrganization -Orgname patton-tech -PAT **********

Connected to https://dev.azure.com/patton-tech/
```

Connecting to your Azure DevOps organization

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1, 7.1-preview.4

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Orgname

This is the Organization Name of your Azure DevOps environment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PAT

A valid Personal Access Token, for more details visit this [page](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
