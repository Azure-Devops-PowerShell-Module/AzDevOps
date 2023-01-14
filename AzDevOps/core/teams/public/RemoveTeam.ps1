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
  [ValidateSet('5.1-preview.3', '7.1-preview.3')]
  [string]$ApiVersion = '7.1-preview.3'
 )
 begin
 {
  Write-Verbose "RemoveTeam  : Begin Processing";
  Write-Verbose " ProjectId  : $($Project.Id)";
  Write-Verbose " TeamId     : $($TeamId)";
  Write-Verbose " ApiVersion : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    $Project = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    $Team = Get-AdoTeam -ProjectId $ProjectId -TeamId $TeamId -Verbose:$VerbosePreference;

    $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)?api-version=$($ApiVersion)"
    if ($PSCmdlet.ShouldProcess("Delete", "Remove team $($Team.name) from $($Project.name) Azure Devops Projects"))
    {
     $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method DELETE -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference;
     if (!($Result))
     {
      return "Team : $($Team.id) removed from Project : $($Project.id)";
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