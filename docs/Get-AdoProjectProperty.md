---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AdoProjectProperty.md#get-adoprojectproperty
schema: 2.0.0
---

# Get-AdoProjectProperty

## SYNOPSIS

Get a collection of team project Property

## SYNTAX

```powershell
Get-AdoProjectProperty [[-Project] <Object>] [[-ApiVersion] <String>] [<CommonParameters>]
```

## DESCRIPTION

Get a collection of team project Property

## EXAMPLES

### Example 1

```powershell
PS C:\> $Project = Get-AdoProject -ProjectId 2e6901c2-7cfb-40ea-901b-dfb439566e13

Get-AdoProjectProperty -Project $Project

name                                         value
----                                         -----
System.CurrentProcessTemplateId              7c062e8f-ae74-44c9-8f7d-9f3b35a73af1
System.Microsoft.TeamFoundation.Team.Default cb24c842-7e32-4438-bf5d-fc67ac28a5c1
System.MSPROJ                                <?xml version="1.0" encoding="utf-8"?>...
System.OriginalProcessTemplateId             55ac9c6a-2a5d-4567-9471-8659f826fe12
System.Process Template                      Microsoft Visual Studio Scrum 2013
System.ProcessTemplateType                   6b724908-ef14-45cf-84f8-768b5384da45
System.SourceControlCapabilityFlags          2
System.SourceControlGitEnabled               True
```

Get all Property from a specific project

### Example 2

```powershell
PS C:\> Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a |Get-AdoProjectProperty

name                                          value
----                                          -----
System.CurrentProcessTemplateId               330f7e99-d497-42eb-9fcd-8f8fec59bc13
System.OriginalProcessTemplateId              330f7e99-d497-42eb-9fcd-8f8fec59bc13
System.ProcessTemplateType                    adcc42ab-9882-485e-a3ed-7678f01f66bc
System.MSPROJ                                 <?xml version="1.0" encoding="utf-8"?>...
System.Process Template                       Agile
System.Microsoft.TeamFoundation.Team.Default  49cf33f8-4c32-4fa2-aa67-b8b49a873ea6
System.SourceControlCapabilityFlags           2
System.SourceControlGitEnabled                True
System.SourceControlGitPermissionsInitialized True
```

Passing a project by pipeline

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1-preview.1, 7.1-preview.1

Required: False
Position: 1
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

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
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

[Connect-AdoOrganization](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#connect-adoorganization)

[Get-AdoProject](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AdoProject.md#get-adoproject)