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
  [Guid]$TeamId
 )

 process
 {
  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try
  {
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    switch ($PSCmdlet.ParameterSetName)
    {
     'Project'
     {
      if ($TeamId)
      {
       $Team = Get-AzDevOpsTeam -ProjectId $Project.Id -TeamId $TeamId
       $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)/members?api-version=5.1"
       return ((Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity)
      }
      else
      {
       foreach ($Team in Get-AzDevOpsTeam -ProjectId $Project.Id)
       {
        $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($Team.id)/members?api-version=5.1"
                  (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity
       }
      }
     }
     'ProjectId'
     {
      $Project = Get-AzDevOpsProject -ProjectId $ProjectId
      if ($TeamId)
      {
       $Team = Get-AzDevOpsTeam -ProjectId $Project.Id -TeamId $TeamId
       $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)/members?api-version=5.1"
       return ((Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity)
      }
      else
      {
       foreach ($Team in Get-AzDevOpsTeam -ProjectId $Project.Id)
       {
        $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($Team.id)/members?api-version=5.1"
                  (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity
       }
      }
     }
    }
   }
   else
   {
    $PSCmdlet.ThrowTerminatingError(
     [System.Management.Automation.ErrorRecord]::new(
              ([System.Management.Automation.ItemNotFoundException]"Not connected to Azure DevOps, please run Connect-AzDevOpsOrganization"),
      'Projects.Functions',
      [System.Management.Automation.ErrorCategory]::OpenError,
      $MyObject
     )
    )
   }
  }
  catch
  {
   throw $_
  }
 }
}