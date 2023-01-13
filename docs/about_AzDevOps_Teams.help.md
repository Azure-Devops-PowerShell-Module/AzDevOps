# AzDevOps_Scopes

## about_azdevops_teams

# SHORT DESCRIPTION

The Teams module provides several functions to work with Azure DevOps Teams.

# LONG DESCRIPTION

Teams within Azure DevOps allow you to group users together to work on specific work items within a project. This module provides some basic functionality for working with Teams in Azure DevOps. In order to use some of these functions you will need to be at least a Project Administrator within the project.

## Get-AdoTeam

This function allows to get a list of all teams within a project or a specific team.

## Get-AdoTeamMember

Each Team is composed of several members and this function will return those members.

## New-AdoTeam

This function allows you to create a Team within the project.

## Remove-AdoTeam

This function allows you to remove a Team from a project. You will need to confirm this action as it is destructive.

## Update-DevOpsTeam

You can change some settings within a Team using this function.

# EXAMPLES

```powershell
PS C:\> Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a |Get-AdoTeam -TeamId e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738


id          : e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
name        : test
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
description : test team
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/e80fdd0d-26d9-48c8-9b8d-fd9edd0ee738
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a

Get a specific team

PS C:\> New-AdoTeam -Name 'a new team' -Description 'this is a great team' -Project (Get-AdoProject -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a)


id          : 32bbede5-9b5f-49f2-9573-6e954bb865bc
name        : a new team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/32bbede5-9b5f-49f2-9573-6e954bb865bc
description : this is a great team
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/32bbede5-9b5f-49f2-9573-6e954bb865bc
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
identity    : @{id=32bbede5-9b5f-49f2-9573-6e954bb865bc; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3710963669-1707733827-2672704974-1995252330-1-3120685155-2277392965-2784624880-900151811; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS0zNzEwOTYzNjY5LTE3MDc3MzM4MjctMjY3MjcwNDk3NC0xOTk1MjUyMzMwLTEtMzEyMDY4NTE1NS0yMjc3MzkyOTY1LTI3ODQ2MjQ4ODAtOTAwMTUxODEx; providerDisplayName=[123456-CustomerAccount]\a new team; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=32bbede5-9b5f-49f2-9573-6e954bb865bc; properties=; resourceVersion=2; metaTypeId=255}

Creating a team by passing a project in the parameter

PS C:\> Update-AdoTeam -Name 'New Dev Team' -Description 'Super Builders' -Team (Get-AdoTeam -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a -TeamId 32bbede5-9b5f-49f2-9573-6e954bb865bc)


id          : 32bbede5-9b5f-49f2-9573-6e954bb865bc
name        : New Dev Team
url         : https://dev.azure.com/patton-tech/_apis/projects/d5cf30dd-c965-43f3-9f4e-3dce76ed226a/teams/32bbede5-9b5f-49f2-9573-6e954bb865bc
description : Super Builders
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/32bbede5-9b5f-49f2-9573-6e954bb865bc
projectName : 123456-CustomerAccount
projectId   : d5cf30dd-c965-43f3-9f4e-3dce76ed226a
identity    : @{id=32bbede5-9b5f-49f2-9573-6e954bb865bc; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-3710963669-1707733827-2672704974-1995252330-1-3120685155-2277392965-2784624880-900151811; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS0zNzEwOTYzNjY5LTE3MDc3MzM4MjctMjY3MjcwNDk3NC0xOTk1MjUyMzMwLTEtMzEyMDY4NTE1NS0yMjc3MzkyOTY1LTI3ODQ2MjQ4ODAtOTAwMTUxODEx; providerDisplayName=[123456-CustomerAccount]\a new team; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=32bbede5-9b5f-49f2-9573-6e954bb865bc; properties=; resourceVersion=2; metaTypeId=255}

Update Team Name and Description

PS C:\> Remove-AdoTeam -ProjectId d5cf30dd-c965-43f3-9f4e-3dce76ed226a -TeamId 9a305dd2-d928-44ab-84bf-03ccaa9b54c4

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove team a whole new team from 123456-CustomerAccount Azure Devops Projects" on target "Delete".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y
```

# NOTE

You will need to have a PAT in order to connect and it's context should provide for managing Teams.

# TROUBLESHOOTING NOTE

Most issues are related to scope of access

# SEE ALSO

Azure Devops Teams
<https://docs.microsoft.com/en-us/azure/devops/organizations/settings/about-teams-and-settings?view=azure-devops>

# KEYWORDS

- Get-AdoProject
- Get-AdoTeam
- Get-AdoTeamMember
- New-AdoTeam
- Remove-AdoTeam
- Update-AdoTeam
