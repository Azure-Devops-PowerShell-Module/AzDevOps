function Get-Team
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AzDevOpsTeam.md#get-azdevopsteam',
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
  Write-Verbose "GetTeam     : Process Record";
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose " ProjectId  : $($Project.Id)";
  }
  else
  {
   Write-Verbose " ProjectId  : $($ProjectId)";
  }
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
    if ($PSCmdlet.ParameterSetName -eq 'ProjectId')
    {
     $Project = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    switch ($PSCmdlet.ParameterSetName)
    {
     'Project'
     {
      if ($TeamId)
      {
       $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($TeamId)?api-version=$($ApiVersion)";
       return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
      }
      else
      {
       $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/?api-version=$($ApiVersion)";
       return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
      }
     }
     default
     {
      $Uri = $Global:azDevOpsOrg + "_apis/teams?api-version=$($ApiVersion)";
      return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
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