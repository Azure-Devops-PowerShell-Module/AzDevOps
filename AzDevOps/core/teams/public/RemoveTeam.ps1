function Remove-Team
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Remove-AzDevOpsTeam.md#remove-azdevopsteam',
  PositionalBinding = $true)]
 [OutputType([string])]
 param (
  [Parameter(Mandatory = $true)]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $true)]
  [Guid]$TeamId
 )

 $ErrorActionPreference = 'Stop'
 $Error.Clear()

 try
 {
  #
  # Are we connected
  #
  if ($Global:azDevOpsConnected)
  {
   $Project = Get-AzDevOpsProject -ProjectId $ProjectId
   $Team = Get-AzDevOpsTeam -ProjectId $ProjectId -TeamId $TeamId

   $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)?api-version=5.1"
   if ($PSCmdlet.ShouldProcess("Delete", "Remove team $($Team.name) from $($Project.name) Azure Devops Projects"))
   {
    $Result = Invoke-RestMethod -Uri $uriProjects -Method Delete -Headers $Global:azDevOpsHeader
    if (!($Result))
    {
     return "Team : $($Team.id) removed from Project : $($Project.id)"
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
