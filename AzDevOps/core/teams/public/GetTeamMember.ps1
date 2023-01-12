function Get-TeamMember
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AzDevOpsTeamMember.md#get-azdevopsteammember',
  PositionalBinding = $true)]
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
  [ValidateSet('5.1-preview.3', '7.1-preview.3')]
  [string]$ApiVersion = '7.1-preview.3'
 )
 process
 {
  Write-Verbose "GetTeamMember     : Process Record";
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose " ProjectId        : $($Project.Id)";
  }
  else
  {
   Write-Verbose " ProjectId        : $($ProjectId)";
  }
  Write-Verbose " TeamId           : $($TeamId)";
  Write-Verbose " ApiVersion       : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($PSCmdlet.ParameterSetName -eq 'ProjectId')
    {
     $Project = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    $Team = Get-AdoTeam -ProjectId $Project.Id -TeamId $TeamId -Verbose:$VerbosePreference;
    switch ($PSCmdlet.ParameterSetName)
    {
     'Project'
     {
      if ($TeamId)
      {
       $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)/members?api-version=$($ApiVersion)"
       return ((Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value | Select-Object -ExpandProperty Identity);
      }
      else
      {
       foreach ($Team in Get-AdoTeam -ProjectId $Project.Id)
       {
        $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($Team.id)/members?api-version=$($ApiVersion)"
        return ((Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value | Select-Object -ExpandProperty Identity);
       }
      }
     }
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}