TOPIC
    about_azdevops_authentication

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
    The AzDevOps Authentication module provides a method for connecting to an
    Azure Devops Organization.

    ABOUT TOPIC NOTE:
    About topics can be no longer than 80 characters wide when rendered to text.
    Any topics greater than 80 characters will be automatically wrapped.
    The generated about topic will be encoded UTF-8.

LONG DESCRIPTION
    This module leverages a Personal Access Token in order to authenticate into
    Azure DevOps. A PAT is an alternate password that allows a simpler method of
    authenticating into Azure DevOps.
    You will need to create the PAT within the Azure Devops Portal before you
    are able to connect.   1. Login to your Azure Devops Organization   2.
    Access your account profile and select User Settings   3. Select Personal
    Access Tokens then click New Token   4. Provide a name, choose the
    organization to use, and set an expiration   5. Define your scopes   6. Copy
    the token and store it in a safe location
    A future release will look to add oAuth authentication which should provide
    a  more robust authentication mechanism than simple PATs.

Connect-AzDevOpsOrganization
    This is the function that is used to connect to AzDevOps.

EXAMPLES
    PS C:\> Connect-AzDevOps -Orgname patton-tech -PAT **********
    
    Connected to https://dev.azure.com/patton-tech/

    Connecting to your Azure DevOps organization

NOTE
    A PAT will need to be created in advance

TROUBLESHOOTING NOTE
    Some issues that can arise with a valid token are scopes that do not provide
    enough access for the action required.

SEE ALSO
    Authenticate access with personal access tokens
    https://docs.microsoft.com/en-us/azure/devops/repos/git/auth-overview?view=azure-devops#personal-access-tokens

KEYWORDS
    Connect, Login, Authenticate, Logon
- Connect-AzDevOpsOrganization

