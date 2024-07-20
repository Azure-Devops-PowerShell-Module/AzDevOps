function Get-Operation
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Get-AdoOperation.md#get-adooperation',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $true)]
  [Guid]$OperationId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.1', '7.2-preview.1')]
  [string]$ApiVersion = '7.2-preview.1'
 )

 begin
 {
  Write-Verbose "GetOperation: Begin Processing"
  Write-Verbose "OperationId: $($OperationId)"
  Write-Verbose "ApiVersion: $($ApiVersion)"
 }

 process
 {
  try
  {
   $ErrorActionPreference = 'Stop'
   $Error.Clear()

   if (-not $Global:azDevOpsConnected)
   {
    throw "Not connected to Azure DevOps. Please connect using Connect-AzDevOps."
   }

   $Uri = "$($Global:azDevOpsOrg)_apis/operations/$($OperationId)?api-version=$($ApiVersion)"
   Write-Verbose "Uri: $($Uri)"

   return Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference
  }
  catch
  {
   throw $_
  }
 }
}