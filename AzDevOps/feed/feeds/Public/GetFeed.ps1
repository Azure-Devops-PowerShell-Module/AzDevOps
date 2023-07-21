function Get-Feed
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AdoFeed.md#get-AdoFeed',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [string]$Project,
  [Parameter(Mandatory = $false)]
  [string]$Name,
  [Parameter(Mandatory = $false)]
  [ValidateSet('7.1-preview.1')]
  [string]$ApiVersion = '7.1-preview.1'
 )
 begin
 {
  Write-Verbose "GetFeed       : Begin Processing";
  Write-Verbose " Project      : $($Project)";
  Write-Verbose " Name         : $($Name)";
  Write-Verbose " ApiVersion   : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($Project)
    {
     $thisProject = Get-AdoProject | Where-Object -Property Name -eq $Project -Verbose:$VerbosePreference;
     Write-Verbose " ProjectId    : $($thisProject.id)";
     $Uri = $Global:azDevOpsFeed + "$($thisProject.id)/_apis/packaging/feeds?api-version=$($ApiVersion)";
     if ($Name)
     {
      $Feed = Get-AdoFeed -Project $thisProject.Name | Where-Object -Property Name -eq $Name -Verbose:$VerbosePreference;
      Write-Verbose " FeedId       : $($Feed.id)";
      $Uri = $Global:azDevOpsFeed + "$($thisProject.id)/_apis/packaging/feeds/$($Feed.id)?api-version=$($ApiVersion)";
      return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
     }
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
    }
    else
    {
     $Uri = $Global:azDevOpsFeed + "_apis/packaging/feeds?api-version=$($ApiVersion)";
     if ($Name)
     {
      $Feed = Get-AdoFeed | Where-Object -Property Name -eq $Name -Verbose:$VerbosePreference;
      Write-Verbose " FeedId       : $($Feed.id)";
      $Uri = $Global:azDevOpsFeed + "_apis/packaging/feeds/$($Feed.id)?api-version=$($ApiVersion)";
      return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference)
     }
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}