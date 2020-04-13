TOPIC
    about_azdevops_operations

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
    This module provides access to long-running operations on Azure DevOps

    ABOUT TOPIC NOTE:
    About topics can be no longer than 80 characters wide when rendered to text.
    Any topics greater than 80 characters will be automatically wrapped.
    The generated about topic will be encoded UTF-8.

LONG DESCRIPTION
    Operations provide a way to monitor the process of an async task. This
    function gets an operation from the the operationId using the given
    pluginId. Some  scenarios don't require a pluginId. If a pluginId is not
    included in the call  then just the operationId will be used to find an
    operation

Get-AzDevOpsOperation
    Gets an operation from the the operationId using the given pluginId

EXAMPLES
    PS C:\> Get-AzDevOpsOperations -OperationId 'c92521c2-5599-4a87-aec6-58afe7b14444'
    
    id                                   status    url                                                                               _links
    --                                   ------    ---                                                                               ------
    c92521c2-5599-4a87-aec6-58afe7b14444 succeeded https://dev.azure.com/patton-tech/_apis/operations/c92521c2-5599-4a87-aec6-58afe7b14444 @{self=}

    Get the status of a running operation

NOTE
    This is used mostly for internal status checks on long runnin processes,
    such as creating new projects and such. It can be used externally as well if
    need be.

KEYWORDS
    operation, operations
- Connect-AzDevOpsOrganization
- New-AzDevOpsProject

