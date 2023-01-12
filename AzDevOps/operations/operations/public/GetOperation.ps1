function Get-Operation
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AzDevOpsOperation.md#get-azdevopsoperation',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $true)]
  [Guid]$OperationId,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.1')]
  [string]$ApiVersion = '7.1-preview.1'
 )
 begin
 {
  try
  {
   Write-Verbose "GetBuild     : Begin Processing";
   Write-Verbose " OperationId : $($OperationId)";
   Write-Verbose " ApiVersion  : $($ApiVersion)";
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    $Uri = $Global:azDevOpsOrg + "_apis/operations/$($OperationId)?api-version=$($ApiVersion)";
    return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
   }
  }
  catch
  {
   throw $_;
  }
 }
}
