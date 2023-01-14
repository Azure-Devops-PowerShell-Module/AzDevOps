# AzDevOps_Scopes

## about_azdevops_processes

# SHORT DESCRIPTION

A process defines the building blocks of a work-tracking system.

# LONG DESCRIPTION

A process defines the building blocks of a work-tracking system. To customize a  process, you first create an inherited process from one of the default system  processes, Agile, Scrum, or CMMI. All projects that use the process see the  changes you make.

## Get-AdoProcess

This function will return one or more Processes from Azure DevOps.

# EXAMPLES

```powershell
PS C:\> Get-AdoProcess


id          : 27450541-8e31-4150-9947-dc59f998fc01
description : This template is for more formal projects requiring a framework for process improvement and an auditable record of decisions.
isDefault   : False
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/27450541-8e31-4150-9947-dc59f998fc01
name        : CMMI

id          : 6b724908-ef14-45cf-84f8-768b5384da45
description : This template is for teams who follow the Scrum framework.
isDefault   : False
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/6b724908-ef14-45cf-84f8-768b5384da45
name        : Scrum

id          : adcc42ab-9882-485e-a3ed-7678f01f66bc
description : This template is flexible and will work great for most teams using Agile planning methods, including those practicing Scrum.
isDefault   : True
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/adcc42ab-9882-485e-a3ed-7678f01f66bc
name        : Agile

id          : b8a3a935-7e91-48b8-a94c-606d37c3e9f2
description : This template is flexible for any process and great for teams getting started with Azure DevOps.
isDefault   : False
type        : system
url         : https://dev.azure.com/patton-tech/_apis/process/processes/b8a3a935-7e91-48b8-a94c-606d37c3e9f2
name        : Basic

```

# NOTE

Get a list of all processes

# KEYWORDS

- Process
- Connect-AdoOrganization
- Get-AdoProcess
