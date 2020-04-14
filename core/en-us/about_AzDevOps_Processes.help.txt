TOPIC
    about_azdevops_processes

    ABOUT TOPIC NOTE:
    The first header of the about topic should be the topic name.
    The second header contains the lookup name used by the help system.
    
    IE:
    # Some Help Topic Name
    ## SomeHelpTopicFileName
    
    This will be transformed into the text file
    as `about_SomeHelpTopicFileName`.
    Do not include file extensions.
    The second header should have no spaces.

SHORT DESCRIPTION
    A process defines the building blocks of a work-tracking system.

    ABOUT TOPIC NOTE:
    About topics can be no longer than 80 characters wide when rendered to text.
    Any topics greater than 80 characters will be automatically wrapped.
    The generated about topic will be encoded UTF-8.

LONG DESCRIPTION
    A process defines the building blocks of a work-tracking system. To
    customize a  process, you first create an inherited process from one of the
    default system  processes, Agile, Scrum, or CMMI. All projects that use the
    process see the  changes you make.

Get-AzDevOpsProcess
    This function will return one or more Processes from Azure DevOps.

EXAMPLES
    PS C:\> Get-AzDevOpsProcess
    
    
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

    Get a list of all processes

KEYWORDS
    process
- Connect-AzDevOpsOrganization
- Get-AzDevOpsProcess

