---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AdoTeamMember.md#get-adoteammember
schema: 2.0.0
---

# Get-AdoTeamMember

## SYNOPSIS

Get a list of members for a specific team.

## SYNTAX

### Project

```powershell
Get-AdoTeamMember [-Project <Object>] [-TeamId <Guid>] [-ApiVersion <String>] [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoTeamMember [-ProjectId <Guid>] [-TeamId <Guid>] [-ApiVersion <String>] [<CommonParameters>]
```

## DESCRIPTION

This function will return a list of members from a specific team, or list members for all teams in the supplised Project.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoTeamMember -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a


displayName : Jeffrey Patton
url         : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797
_links      : @{avatar=}
id          : 636851f0-e884-48a4-962e-f1d1bcc29797
uniqueName  : jeffrey@patton-tech.com
imageUrl    : https://dev.azure.com/patton-tech/_api/_common/identityImage?id=636851f0-e884-48a4-962e-f1d1bcc29797
descriptor  : aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0
```

Get all members of all teams in the project (only one team has a member in this example)

### Example 2

```powershell
PS C:\> Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a |Get-AdoTeamMember -TeamId 49cf33f8-4c32-4fa2-aa67-b8b49a873ea6


displayName : Jeffrey Patton
url         : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/636851f0-e884-48a4-962e-f1d1bcc29797
_links      : @{avatar=}
id          : 636851f0-e884-48a4-962e-f1d1bcc29797
uniqueName  : jeffrey@patton-tech.com
imageUrl    : https://dev.azure.com/patton-tech/_api/_common/identityImage?id=636851f0-e884-48a4-962e-f1d1bcc29797
descriptor  : aad.ZGQwYzI1YzQtNGY3MC03MThkLTgzNWYtYzJkMzlkZDRiNTA0
```

Get all members of a specific team in the project (team has only one member in htis example)

## PARAMETERS

### -ApiVersion

A valid API Version for this endpoint

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 5.1-preview.3, 7.1-preview.3

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

[Get-AdoProject](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AdoProject.md#Get-adoproject)

[Get-AdoTeam](https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AdoTeam.md#get-adoteam)
