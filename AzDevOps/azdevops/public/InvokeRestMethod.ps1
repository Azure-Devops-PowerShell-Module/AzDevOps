function Invoke-RestMethod
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Invoke-RestMethod.md#invoke-restmethod',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandator = $true)]
  [System.Uri]$Uri,
  [Parameter(Mandatory = $true)]
  [validateset('GET','POST')]
  [string]$Method,
  [Parameter(Mandatory = $false)]
  [string]$Headers = $Global:azDevOpsHeader,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7')]
  [string]$ApiVersion = '7.1-preview.7'
 )

 $ErrorActionPreference = 'Stop'
 $Error.Clear()

 try
 {
  #
  # Are we connected
  #
  if ($Global:azDevOpsConnected)
  {
   return (Invoke-RestMethod -Uri $Uri -Method $Method -Headers $Headers)
  }
  else
  {
   [System.Management.Automation.ItemNotFoundException]$Exception = "Not connected to Azure DevOps, please run Connect-AzDevOpsOrganization";
   [string]$ErrorId = 'Projects.Functions';
   [System.Management.Automation.ErrorCategory]$ErrorCategory = [System.Management.Automation.ErrorCategory]::OpenError;
   $PSCmdlet.ThrowTerminatingError(
    [System.Management.Automation.ErrorRecord]::new($Exception,$ErrorId,$ErrorCategory,$MyObject)
   )
  }
 }
 catch
 {
  throw $_
 }
}
