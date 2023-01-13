---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Update-AdoTeam.md#update-adoteam
schema: 2.0.0
---

# Update-AdoTeam

## SYNOPSIS

Update a team's name and/or description

## SYNTAX

```powershell
Update-AdoTeam [[-Name] <String>] [[-Description] <String>] [[-Team] <Object>] [[-ApiVersion] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function provides a way to modify some team properties

## EXAMPLES

### Example 1

```powershell
PS C:\> Update-AdoTeam -Name 'New Dev Team' -Description 'Super Builders' -Team (Get-AdoTeam -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a -TeamId 32bbede5-9b5f-49f2-9573-6e954bb865bc)


id          : 32bbede5-9b5f-49f2-9573-6e954bb865bc
name        : New Dev Team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/32bbede5-9b5f-49f2-9573-6e954bb865bc
description : Super Builders
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/32bbede5-9b5f-49f2-9573-6e954bb865bc
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
identity    : @{id=32bbede5-9b5f-49f2-9573-6e954bb865bc; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3710963669-1707733827-2672704974-1995252330-1-3120685155-2277392965-2784624880-900151811; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS0zNzEwOTYzNjY5LTE3MDc3MzM4MjctMjY3MjcwNDk3NC0xOTk1MjUyMzMwLTEtMzEyMDY4NTE1NS0yMjc3MzkyOTY1LTI3ODQ2MjQ4ODAtOTAwMTUxODEx; providerDisplayName=[123456-CustomerAccount]\a new team; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=32bbede5-9b5f-49f2-9573-6e954bb865bc; properties=; resourceVersion=2; metaTypeId=255}
```

Update Team Name and Description

### Example 2

```powershell
PS C:\> Get-AdoTeam -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a -TeamId 32bbede5-9b5f-49f2-9573-6e954bb865bc |Update-AdoTeam -Name 'Build Team'


id          : 32bbede5-9b5f-49f2-9573-6e954bb865bc
name        : Build Team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/32bbede5-9b5f-49f2-9573-6e954bb865bc
description :
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/32bbede5-9b5f-49f2-9573-6e954bb865bc
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
identity    : @{id=32bbede5-9b5f-49f2-9573-6e954bb865bc; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3710963669-1707733827-2672704974-1995252330-1-3120685155-2277392965-2784624880-900151811; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS0zNzEwOTYzNjY5LTE3MDc3MzM4MjctMjY3MjcwNDk3NC0xOTk1MjUyMzMwLTEtMzEyMDY4NTE1NS0yMjc3MzkyOTY1LTI3ODQ2MjQ4ODAtOTAwMTUxODEx; providerDisplayName=[123456-CustomerAccount]\New Dev Team; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=32bbede5-9b5f-49f2-9573-6e954bb865bc; properties=; resourceVersion=2; metaTypeId=255}
```

Pass a Team along the pipeline to update

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

A descriptive name for the Team

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

A Team name

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Team

A Team Object

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
