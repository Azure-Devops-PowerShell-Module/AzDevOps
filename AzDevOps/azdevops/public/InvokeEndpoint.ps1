function Invoke-Endpoint
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Invoke-RestMethod.md#invoke-restmethod',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $true)]
  [System.Uri]$Uri,
  [Parameter(Mandatory = $true)]
  [validateset('GET', 'POST', 'PUT', 'DELETE')]
  [string]$Method,
  [Parameter(Mandatory = $false)]
  [hashtable]$Headers = $Global:azDevOpsHeader,
  [Parameter(Mandatory = $false)]
  [string]$ContentType,
  [Parameter(Mandatory = $false)]
  [string]$Body
 )
 begin
 {
  Write-Verbose "InvokeRestMethod : Begin Processing"
  Write-Verbose " Uri             : $($Uri.AbsoluteUri)"
  Write-Verbose " Method          : $($Method)"
  Write-Verbose " Headers         : $($Headers)"
  $ErrorActionPreference = 'Stop'
  $Error.Clear()
  try
  {
   #
   # Are we connected
   #
   switch ($Method)
   {
    "POST"
    {
     return (Invoke-RestMethod -Uri $Uri.AbsoluteUri -Method $Method -Headers $Headers -ContentType $ContentType -Body $Body -Verbose:$VerbosePreference);
    }
    "PUT"
    {
     return (Invoke-RestMethod -Uri $Uri.AbsoluteUri -Method $Method -Headers $Headers -ContentType $ContentType -Body $Body -Verbose:$VerbosePreference);
    }
    default
    {
     return (Invoke-RestMethod -Uri $Uri.AbsoluteUri -Method $Method -Headers $Headers -Verbose:$VerbosePreference);
    }
   }
   else
   {
   }
  }
  catch
  {
   throw $_
  }
 }
}
