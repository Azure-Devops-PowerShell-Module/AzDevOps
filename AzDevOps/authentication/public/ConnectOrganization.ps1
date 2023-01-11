function Connect-Organization
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AzDevOpsOrganization.md#connect-azdevopsOrganization',
  PositionalBinding = $true)]
 [OutputType([String])]
 param (
  [Parameter(Mandatory = $true)]
  [string]$Orgname,
  [Parameter(Mandatory = $true)]
  [string]$PAT,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4')]
  [string]$ApiVersion = '7.1-preview.4'
 )

 $azDevOpsHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PAT)")) }
 $azDevOpsOrg = "https://dev.azure.com/$($Orgname)/"

 $uriProjects = $azDevOpsOrg + "_apis/projects?api-version=$($ApiVersion)"
 $Result = Invoke-RestMethod -Uri $uriProjects -Method get -Headers $azDevOpsHeader
 if ($Result.GetType().Name -ne 'String')
 {
  Set-Variable -Name azDevOpsHeader -Value $azDevOpsHeader -Scope Global
  Set-Variable -Name azDevOpsOrg -Value $azDevOpsOrg -Scope Global
  Set-Variable -Name azDevOpsConnected -Value $true -Scope Global
  return "Connected to $($azDevOpsOrg)"
 }
 else
 {
  $PSCmdlet.ThrowTerminatingError(
   [System.Management.Automation.ErrorRecord]::new(
          ([System.Net.WebSockets.WebSocketException]"Failed to connect to Azure DevOps, please check OrgName or Token"),
    'Authentication.Functions',
    [System.Management.Automation.ErrorCategory]::OpenError,
    $MyObject
   )
  )
 }
}
