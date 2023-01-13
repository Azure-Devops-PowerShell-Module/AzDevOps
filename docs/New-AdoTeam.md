---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/New-AdoTeam.md#new-adoteam
schema: 2.0.0
---

# New-AdoTeam

## SYNOPSIS

Create a team in a team project

## SYNTAX

```powershell
New-AdoTeam [-Name] <String> [[-Description] <String>] [[-Project] <Object>] [[-ApiVersion] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function allows you to create a new team in an Azure Devops Project

## EXAMPLES

### Example 1

```powershell
PS C:\> New-AdoTeam -Name 'a new team' -Description 'this is a great team' -Project (Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a)


id          : 32bbede5-9b5f-49f2-9573-6e954bb865bc
name        : a new team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/32bbede5-9b5f-49f2-9573-6e954bb865bc
description : this is a great team
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/32bbede5-9b5f-49f2-9573-6e954bb865bc
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
identity    : @{id=32bbede5-9b5f-49f2-9573-6e954bb865bc; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3710963669-1707733827-2672704974-1995252330-1-3120685155-2277392965-2784624880-900151811; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS0zNzEwOTYzNjY5LTE3MDc3MzM4MjctMjY3MjcwNDk3NC0xOTk1MjUyMzMwLTEtMzEyMDY4NTE1NS0yMjc3MzkyOTY1LTI3ODQ2MjQ4ODAtOTAwMTUxODEx; providerDisplayName=[123456-CustomerAccount]\a new team; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=32bbede5-9b5f-49f2-9573-6e954bb865bc; properties=; resourceVersion=2; metaTypeId=255}
```

Creating a team by passing a project in the parameter

### Example 2

```powershell
PS C:\> Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a |New-AdoTeam -Name 'a whole new team' -Description 'this team is even better'


id          : 9a305dd2-d928-44ab-84bf-03ccaa9b54c4
name        : a whole new team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/9a305dd2-d928-44ab-84bf-03ccaa9b54c4
description : this team is even better
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/9a305dd2-d928-44ab-84bf-03ccaa9b54c4
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
identity    : @{id=9a305dd2-d928-44ab-84bf-03ccaa9b54c4; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3710963669-1707733827-2672704974-1995252330-1-3101610963-1451776323-2212708059-2298500323; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS0zNzEwOTYzNjY5LTE3MDc3MzM4MjctMjY3MjcwNDk3NC0xOTk1MjUyMzMwLTEtMzEwMTYxMDk2My0xNDUxNzc2MzIzLTIyMTI3MDgwNTktMjI5ODUwMDMyMw; providerDisplayName=[123456-CustomerAccount]\a whole new team; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=9a305dd2-d928-44ab-84bf-03ccaa9b54c4; properties=; resourceVersion=2; metaTypeId=255}
```

Creating a team by passing the project along the pipeline

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1-preview.3, 7.1-preview.3

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

A descriptive name for the team

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

The team name

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

### -Project

A project object

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
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

[Connect-AdoOrganization](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#connect-adoorganization)
