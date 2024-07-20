---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AdoTeam.md#get-Adoteam
schema: 2.0.0
---

# Get-AdoTeam

## SYNOPSIS

Get a specific team

## SYNTAX

### Project

```powershell
Get-AdoTeam [-Project <Object>] [-TeamId <Guid>] [-ApiVersion <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoTeam [-ProjectId <Guid>] [-TeamId <Guid>] [-ApiVersion <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

This function will return a specific team, or all teams in a given project

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoTeam -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a


id          : e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
name        : test
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
description : test team
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a

id          : 7bd13209-d593-415d-9d47-9e4136ccf9e5
name        : test3
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/7bd13209-d593-415d-9d47-9e4136ccf9e5
description : test team3
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/7bd13209-d593-415d-9d47-9e4136ccf9e5
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a

id          : 49cf33f8-4c32-4fa2-aa67-b8b49a873ea6
name        : 123456-CustomerAccount Team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/49cf33f8-4c32-4fa2-aa67-b8b49a873ea6
description : The default project team.
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/49cf33f8-4c32-4fa2-aa67-b8b49a873ea6
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
```

Get all teams in the project

### Example 2

```powershell
PS C:\> Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a |Get-AdoTeam -TeamId e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738


id          : e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
name        : test
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
description : test team
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
```

Get a specific team

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1-preview.3, 7.1-preview.3, 7.2-preview.3

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Project

A project object as returned from Get-AdoProject

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

A Project Id

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

### -TeamId

A Team Id

```yaml
Type: System.Guid
Parameter Sets: (All)
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

[Connect-AdoOrganization](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#connect-adoorganization)

[Get-AdoProject](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AdoProject.md#get-adoproject)
