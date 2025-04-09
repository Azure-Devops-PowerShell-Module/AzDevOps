function Get-Team
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AdoTeam.md#get-adoteam',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$TeamId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.3', '7.1-preview.3', '7.2-preview.3')]
  [string]$ApiVersion = '7.2-preview.3'
 )

 process
 {
  Write-Verbose "GetTeam: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "ProjectId: $($Project.Id)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "TeamId: $($TeamId)"
  Write-Verbose "ApiVersion: $($ApiVersion)"

  try
  {
   $ErrorActionPreference = 'Stop'
   $Error.Clear()

   if (-not $Global:azDevOpsConnected)
   {
    throw "Not connected to Azure DevOps. Please connect using Connect-AdoOrganization."
   }

   $BaseUri = if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    "$($Global:azDevOpsOrg)_apis/projects/$($Project.Id)/teams"
   }
   else
   {
    "$($Global:azDevOpsOrg)_apis/projects/$($ProjectId)/teams"
   }

   if ($TeamId)
   {
    $Uri = "$($BaseUri)/$($TeamId)?api-version=$($ApiVersion)"
   }
   else
   {
    $Uri = "$($BaseUri)?api-version=$($ApiVersion)"
   }

   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($TeamId)
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