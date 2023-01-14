---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuild.md#get-adobuild
schema: 2.0.0
---

# Get-AdoBuild

## SYNOPSIS

Return one or more builds from a project

## SYNTAX

### Project

```powershell
Get-AdoBuild [-Project <Object>] [-BuildId <Int32>] [-ApiVersion <String>] [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoBuild [-ProjectId <Guid>] [-BuildId <Int32>] [-ApiVersion <String>] [<CommonParameters>]
```

## DESCRIPTION

This function will allow you to get a list of builds within a project or return
a specific build from a project

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoBuild -Project $Project

_links                       : @{self=; web=; sourceVersionDisplayUri=; timeline=; badge=}
properties                   :
tags                         : {}
validationResults            : {}
plans                        : {@{planId=d6f142f2-e0cc-4e3e-ba38-4a27bff743c1}}
triggerInfo                  :
id                           : 195
buildNumber                  : 20200810.17
...
appendCommitMessageToRunName : True
```

Get a list of builds

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

### -BuildId

The build id for the build

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

The project where the build(s) can be found

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

The project id of the  project where the build(s) can be found

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
