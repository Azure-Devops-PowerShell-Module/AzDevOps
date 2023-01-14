# AzDevOps_Scopes

## about_azdevops_authentication

# SHORT DESCRIPTION

The AzDevOps Authentication module provides a method for connecting to an Azure Devops Organization.


# LONG DESCRIPTION

This module leverages a Personal Access Token in order to authenticate into Azure DevOps. A PAT is an alternate password that allows a simpler method of authenticating into Azure DevOps. You will need to create the PAT within the Azure Devops Portal before youare able to connect.

1. Login to your Azure Devops Organization
2. Access your account profile and select User Settings
3. Select Personal Access Tokens then click New Token
4. Provide a name, choose the organization to use, and set an expiration
5. Define your scopes
6. Copy the token and store it in a safe location

A future release will look to add oAuth authentication which should provide a  more robust authentication mechanism than simple PATs.

## Connect-AzDevOpsOrganization

This is the function that is used to connect to AzDevOps.

# EXAMPLES

```powershell
PS C:\> Connect-AdoOrganization -Orgname patton-tech -PAT **********

Connected to https://dev.azure.com/patton-tech/
```

Connecting to your Azure DevOps organization

# NOTE

A PAT will need to be created in advance

# TROUBLESHOOTING NOTE

Some issues that can arise with a valid token are scopes that do not provide enough access for the action required.

# SEE ALSO

Authenticate access with personal access tokens
<https://docs.microsoft.com/en-us/azure/devops/repos/git/auth-overview?view=azure-devops#personal-access-tokens>

# KEYWORDS

- Connect
- Login
- Authenticate
- Logon
- Connect-AdoOrganization
