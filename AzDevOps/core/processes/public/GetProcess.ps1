function Get-Process
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/processes/blob/master/docs/Get-AdoProcess.md#get-adoprocess',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [Guid]$ProcessId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.1', '7.2-preview.1')]
  [string]$ApiVersion = '7.2-preview.1'
 )

 begin
 {
  Write-Verbose "GetProcess: Begin Processing"
  Write-Verbose "ProcessId: $($ProcessId)"
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
    throw "Not connected to Azure DevOps. Please connect using Connect-AdoOrganization."
   }

   if ($ProcessId)
   {
    $Uri = "$($Global:azDevOpsOrg)_apis/process/processes/$($ProcessId)?api-version=$($ApiVersion)"
   }
   else
   {
    $Uri = "$($Global:azDevOpsOrg)_apis/process/processes?api-version=$($ApiVersion)"
   }

   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($ProcessId)
   {
    return $Response
   }
   else
   {
    return $Response.Value
   }
  }
  catch
  {
   throw $_
  }
 }
}