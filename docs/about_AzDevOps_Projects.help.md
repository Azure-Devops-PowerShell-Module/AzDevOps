﻿# AzDevOps_Scopes

## about_azdevops_projects

# SHORT DESCRIPTION

The Projects module provides functions for working with and manging projects in Azure Devops.

# LONG DESCRIPTION

A project, which was previously known as a team project, provides a repository  for source code. A project provides a place where a group of people can plan,  track progress, and collaborate on building software solutions. A project is  defined for an Azure DevOps Services organization or within a TFS project  collection. You can use it to focus on those objects defined within the project.

## Get-AdoProject

This function returns a project from an Azure Devop Organization. This function will be used for almost all types of operations as we are typically working with resources within a given project.

## Get-AdoProjectProperty

This function will return some extended information about a given project.

## New-AdoProject

This function allows you to create a new project.

## Remove-AdoProject

This function will remove a project from an Azure Devops Organization. You will need to provide confirmation as it's a destructive operation.

# EXAMPLES

```powershell
    PS C:\> Get-AdoProject -ProjectId 2e6901c2-7cfb-40ea-901b-dfb439566e13


    id             : 2e6901c2-7cfb-40ea-901b-dfb439566e13
    name           : sample
    url            : https://dev.azure.com/patton-tech/_apis/projects/2e6901c2-7cfb-40ea-901b-dfb439566e13
    state          : wellFormed
    revision       : 515330550
    _links         : @{self=; collection=; web=}
    visibility     : private
    defaultTeam    : @{id=cb24c842-7e32-4438-bf5d-fc67ac28a5c1; name=sample Team; url=https://dev.azure.com/patton-tech/_apis/projects/2e6901c2-7cfb-40ea-901b-dfb439566e13/teams/cb24c842-7e32-4438-bf5d-fc67ac28a5c1}
    lastUpdateTime : 2015-08-13T01:10:08.653Z
```

# NOTE

Get a single project

# EXAMPLES

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

# NOTE

Passing a project by pipeline

# EXAMPLES

```powershell
    PS C:\> New-AdoProject -Name TestProject -Description 'this is a new project'

    id                                   status url
    --                                   ------ ---
    859ba28b-918b-4eaf-a819-b0024b9dd9e5 notSet https://dev.azure.com/patton-tech/_apis/operations/859ba28b-918b-4eaf-a819-b0024b9dd9e5
```

# NOTE

Creating a new project

# EXAMPLES

```powershell
    PS C:\> $Project = Get-AdoProject 4027d479-6afb-4201-9646-c580bf8d7251

    $Project


    id             : 4027d479-6afb-4201-9646-c580bf8d7251
    name           : newproject
    description    : this is a new project
    url            : https://dev.azure.com/patton-tech/_apis/projects/4027d479-6afb-4201-9646-c580bf8d7251
    state          : wellFormed
    revision       : 515330653
    _links         : @{self=; collection=; web=}
    visibility     : private
    defaultTeam    : @{id=25008b15-01a6-4b27-a9f9-5872e2713b87; name=newproject Team; url=https://dev.azure.com/patton-tech/_apis/projects/4027d479-6afb-4201-9646-c580bf8d7251/teams/25008b15-01a6-4b27-a9f9-5872e2713b87}
    lastUpdateTime : 2020-04-08T19:28:13.077Z

    Remove-AdoProject -Project $Project

    id                                   status url
    --                                   ------ ---
    1569ba20-7ed2-4ff0-8c1f-412bbcc3700d notSet https://dev.azure.com/patton-tech/_apis/operations/1569ba20-7ed2-4ff0-8c1f-412bbcc3700d
```

# NOTE

Deleting a project

# NOTE

You will need to be authenticated with a PAT in order for these functions to work. Additionally the PAT will need to be scoped appropriately in order to perform create and delete operations.

# TROUBLESHOOTING NOTE

{{ Troubleshooting Placeholder - Warns users of bugs}}

{{ Explains behavior that is likely to change with fixes }}

# SEE ALSO

The most commone source of issues are around the scope of the token. Please verify that your token is able to access projects.

# KEYWORDS

- Connect-AdoOrganization
- Get-AdoProject
- Get-AdoProjectProperty
- New-AdoProject
- Remove-AdoProject
