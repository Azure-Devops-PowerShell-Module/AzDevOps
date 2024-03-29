﻿# AzDevOps

## about_AzDevOps

# SHORT DESCRIPTION

A module for working with Azure Devops Organizations

# LONG DESCRIPTION

This module provides the ability to manage and work with an Azure Devops
organization.

## Working with Projects

This will walk through connecting to an Azure Devops Organization, creating
a project and renaming the project. Then this will cover creating a Team
within the project, making a change to that team. Finally this will cover
removing everything that was created.

# EXAMPLES

```
Connect-AzDevOpsOrganization -Orgname patton-tech -PAT ******
Connected to https://dev.azure.com/patton-tech/
```

Connect to Azure Devops

```
New-AzDevOpsProject -Name sampleproject -Description 'A project to show how to work with Devops'


id             : 45ace62e-3bf1-48de-8648-2a07741f5f97
name           : sampleproject
description    : A project to show how to work with Devops
url            : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97
state          : wellFormed
revision       : 515330788
visibility     : private
lastUpdateTime : 2020-04-14T16:41:30.987Z
```

Create a new project

```
Get-AzDevOpsProject -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97 `
 |Update-AzDevOpsProject -Name NewProject -Abbreviation 'anp'


id             : 45ace62e-3bf1-48de-8648-2a07741f5f97
abbreviation   : anp
name           : NewProject
description    : A project to show how to work with Devops
url            : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97
state          : wellFormed
revision       : 515330789
_links         : @{self=; collection=; web=}
visibility     : private
defaultTeam    : @{id=673d45be-8a12-4f20-8c18-61bd37e41e13; name=sampleproject Team; url=https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97/teams/673d45be-8a12-4f20-8c18-61bd37e41e13}
lastUpdateTime : 2020-04-14T16:42:11.04Z
```

Update a project

```
Get-AzDevOpsProject -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97 `
|Get-AzDevOpsTeam


id          : 673d45be-8a12-4f20-8c18-61bd37e41e13
name        : NewProject Team
url         : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97/teams/673d45be-8a12-4f20-8c18-61bd37e41e13
description : The default project team.
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/673d45be-8a12-4f20-8c18-61bd37e41e13
projectName : NewProject
projectId   : 45ace62e-3bf1-48de-8648-2a07741f5f97
```

Get a list of default teams

```
Get-AzDevOpsProject -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97 `
|New-AzDevOpsTeam -Name 'DevTeam' -Description 'A team for developers'


id          : c28e74b4-c403-4d9d-a0df-515a423c5f0a
name        : DevTeam
url         : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97/teams/c28e74b4-c403-4d9d-a0df-515a423c5f0a
description : A team for developers
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/c28e74b4-c403-4d9d-a0df-515a423c5f0a
projectName : NewProject
projectId   : 45ace62e-3bf1-48de-8648-2a07741f5f97
identity    : @{id=c28e74b4-c403-4d9d-a0df-515a423c5f0a; descriptor=Microsoft.TeamFoundation.Identity;S-1-9-1551374245-786869317-4047232584-2252876295-1948213143-1-1214940583-4291806031-3104285065-2988544660; subjectDescriptor=vssgp.Uy0xLTktMTU1MTM3NDI0NS03ODY4NjkzMTctNDA0NzIzMjU4NC0yMjUyODc2Mjk1LTE5NDgyMTMxNDMtMS0xMjE0OTQwNTgzLTQyOTE4MDYwMzEtMzEwNDI4NTA2NS0yOTg4NTQ0NjYw; providerDisplayName=[NewProject]\DevTeam; isActive=True; isContainer=True; members=System.Object[]; memberOf=System.Object[]; masterId=c28e74b4-c403-4d9d-a0df-515a423c5f0a; properties=; resourceVersion=2; metaTypeId=255}
```

Create a new team

```
Get-AzDevOpsProject -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97 `
|Get-AzDevOpsTeam


id          : c28e74b4-c403-4d9d-a0df-515a423c5f0a
name        : DevTeam
url         : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97/teams/c28e74b4-c403-4d9d-a0df-515a423c5f0a
description : A team for developers
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/c28e74b4-c403-4d9d-a0df-515a423c5f0a
projectName : NewProject
projectId   : 45ace62e-3bf1-48de-8648-2a07741f5f97

id          : 673d45be-8a12-4f20-8c18-61bd37e41e13
name        : NewProject Team
url         : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97/teams/673d45be-8a12-4f20-8c18-61bd37e41e13
description : The default project team.
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/673d45be-8a12-4f20-8c18-61bd37e41e13
projectName : NewProject
projectId   : 45ace62e-3bf1-48de-8648-2a07741f5f97
```

List teams in the project

```
Remove-AzDevOpsTeam -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97 -TeamId c28e74b4-c403-4d9d-a0df-515a423c5f0a

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove team DevTeam from NewProject Azure Devops Projects" on target "Delete".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y
Team : c28e74b4-c403-4d9d-a0df-515a423c5f0a removed from Project : 45ace62e-3bf1-48de-8648-2a07741f5f97
```

Delete a team from the project

```
Get-AzDevOpsProject -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97 `
|Get-AzDevOpsTeam


id          : 673d45be-8a12-4f20-8c18-61bd37e41e13
name        : NewProject Team
url         : https://dev.azure.com/patton-tech/_apis/projects/45ace62e-3bf1-48de-8648-2a07741f5f97/teams/673d45be-8a12-4f20-8c18-61bd37e41e13
description : The default project team.
identityUrl : https://spsprodeus27.vssps.visualstudio.com/A098ee851-8ad4-482f-834b-e68ea8489c4d/_apis/Identities/673d45be-8a12-4f20-8c18-61bd37e41e13
projectName : NewProject
projectId   : 45ace62e-3bf1-48de-8648-2a07741f5f97
```

list teams in the project

```
Remove-AzDevOpsProject -Project (Get-AzDevOpsProject -ProjectId 45ace62e-3bf1-48de-8648-2a07741f5f97)

Confirm
Are you sure you want to perform this action?
Performing the operation "Delete NewProject from https://dev.azure.com/patton-tech/ Azure Devops" on target "Remove".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y
Project NewProject removed
```

Remove a project

# NOTE

You will need to create the PAT within the Azure Devops Portal before you
are able to connect.

- 1. Login to your Azure Devops Organization
- 2. Access your account profile and select User Settings
- 3. Select Personal Access Tokens then click New Token
- 4. Provide a name, choose the organization to use, and set an expiration
- 5. Define your scopes
- 6. Copy the token and store it in a safe location

# TROUBLESHOOTING NOTE

Most issues relate to security, as the module stands now, you will need to make
sure that your PAT has enough permissions to perform the tasks required.

# SEE ALSO
<https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/wiki>
