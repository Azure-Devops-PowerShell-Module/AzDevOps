function Get-Process
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/processes/blob/master/docs/Get-AzDevOpsProcess.md#get-azdevopsprocess',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [Guid]$ProcessId,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.1')]
  [string]$ApiVersion = '7.1-preview.1'
 )
 begin
 {
  Write-Verbose "GetProcess    : Begin Processing";
  Write-Verbose " ProcessId    : $($ProcessId)";
  Write-Verbose " ApiVersion   : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($ProcessId)
    {
     $Uri = $Global:azDevOpsOrg + "_apis/process/processes/$($ProcessId)?api-version=$($ApiVersion)";
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
    }
    else
    {
     $Uri = $Global:azDevOpsOrg + "_apis/process/processes?api-version=$($ApiVersion)"
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}