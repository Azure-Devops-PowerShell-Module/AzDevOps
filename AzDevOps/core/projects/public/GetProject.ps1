function Get-Project
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AdoProject.md#get-adoproject',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4', '7.2-preview.4')]
  [string]$ApiVersion = '7.2-preview.4'
 )

 begin
 {
  Write-Verbose "GetProject: Begin Processing"
  Write-Verbose "ProjectId: $($ProjectId)"
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

   if ($ProjectId)
   {
    $Uri = "$($Global:azDevOpsOrg)_apis/projects/$($ProjectId)?api-version=$($ApiVersion)"
   }
   else
   {
    $Uri = "$($Global:azDevOpsOrg)_apis/projects?api-version=$($ApiVersion)"
   }

   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($ProjectId)
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
   Write-Error "Error retrieving project(s): $($_)"
   throw $_
  }
 }
}