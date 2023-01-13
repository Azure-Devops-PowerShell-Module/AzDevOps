# AzDevOps_Scopes

## about_azdevops_operations

# SHORT DESCRIPTION

This module provides access to long-running operations on Azure DevOps

# LONG DESCRIPTION

Operations provide a way to monitor the process of an async task. This function gets an operation from the the operationId using the given pluginId. Some  scenarios don't require a pluginId. If a pluginId is not included in the call  then just the operationId will be used to find an operation

## Get-AdoOperation

Gets an operation from the the operationId using the given pluginId

# EXAMPLES

```powershell
PS C:\> Get-AdoOperations -OperationId 'c92521c2-5599-4a87-aec6-58afe7b14444'

id                                   status    url                                                                               _links
--                                   ------    ---                                                                               ------
c92521c2-5599-4a87-aec6-58afe7b14444 succeeded https://dev.azure.com/patton-tech/_apis/operations/c92521c2-5599-4a87-aec6-58afe7b14444 @{self=}
```

# NOTE

This is used mostly for internal status checks on long runnin processes, such as creating new projects and such. It can be used externally as well if need be.

# KEYWORDS

- Operations
- Operation
- Connect-AdoOrganization
- New-AdoOpsProject
