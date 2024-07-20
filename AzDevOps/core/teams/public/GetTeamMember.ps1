function Get-TeamMember
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AdoTeamMember.md#get-adoteammember',
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
  [ValidateSet('5.1-preview.3', '7.1-preview.3', '7.2-preview.2')]
  [string]$ApiVersion = '7.2-preview.2'
 )

 process
 {
  Write-Verbose "GetTeamMember: Process Record"
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
    throw "Not connected to Azure DevOps. Please connect using Connect-AzDevOps."
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
    $Uri = "$($BaseUri)/$($TeamId)/members?api-version=$($ApiVersion)"
    Write-Verbose "Uri: $($Uri)"
    return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value | Select-Object -ExpandProperty Identity
   }
   else
   {
    $TeamsUri = "$($BaseUri)?api-version=$($ApiVersion)"
    Write-Verbose "TeamsUri: $($TeamsUri)"
    $Teams = (Invoke-AdoEndpoint -Uri ([System.Uri]::new($TeamsUri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value
    $Members = @()

    foreach ($Team in $Teams)
    {
     $Uri = "$($BaseUri)/$($Team.id)/members?api-version=$($ApiVersion)"
     Write-Verbose "Uri: $($Uri)"
     $Members += (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value | Select-Object -ExpandProperty Identity
    }

    return $Members
   }
  }
  catch
  {
   throw $_
  }
 }
}