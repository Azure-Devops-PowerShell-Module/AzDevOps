function Remove-Team
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Remove-AdoTeam.md#remove-adoteam',
  PositionalBinding = $true)]
 [OutputType([string])]
 param (
  [Parameter(Mandatory = $true)]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $true)]
  [Guid]$TeamId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.3', '7.1-preview.3', '7.2-preview.3')]
  [string]$ApiVersion = '7.2-preview.3'
 )

 begin
 {
  Write-Verbose "RemoveTeam: Begin Processing"
  Write-Verbose "ProjectId: $($ProjectId)"
  Write-Verbose "TeamId: $($TeamId)"
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

   $Uri = "$($Global:azDevOpsOrg)_apis/projects/$($ProjectId)/teams/$($TeamId)?api-version=$($ApiVersion)"
   Write-Verbose "Uri: $($Uri)"

   if ($PSCmdlet.ShouldProcess("Delete", "Remove team with ID $($TeamId) from project with ID $($ProjectId)"))
   {
    $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method DELETE -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference
    if (-not $Result)
    {
     return "Team: $($TeamId) removed from Project: $($ProjectId)"
    }
   }
  }
  catch
  {
   throw $_
  }
 }
}