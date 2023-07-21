function Get-FeedView
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AdoFeedView.md#get-adofeedview',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [string]$Project,
  [Parameter(Mandatory = $true)]
  [string]$Feed,
  [Parameter(Mandatory = $false)]
  [string]$Name,
  [Parameter(Mandatory = $false)]
  [ValidateSet('7.1-preview.1')]
  [string]$ApiVersion = '7.1-preview.1'
 )
 begin
 {
  Write-Verbose "GetFeedView       : Begin Processing";
  Write-Verbose " Project          : $($Project)";
  Write-Verbose " Feed             : $($Feed)";
  Write-Verbose " Name             : $($Name)";
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
    if (!([string]::IsNullOrEmpty($Feed)) -and ([string]::IsNullOrEmpty($Project)) -and ([string]::IsNullOrEmpty($Name)))
    {
     $thisFeed = Get-AdoFeed -Name $Feed -Verbose:$VerbosePreference;
     $Uri = $Global:azDevOpsFeed + "_apis/packaging/feeds/$($thisFeed.id)/views?api-version=$($ApiVersion)";
     Write-Verbose "GetFeedView       : All Org Views";
     Write-Verbose " Feed             : $($thisFeed.id)";
    }
    if (!([string]::IsNullOrEmpty($Feed)) -and ([string]::IsNullOrEmpty($Project)) -and !(([string]::IsNullOrEmpty($Name))))
    {
     $thisFeed = Get-AdoFeed -Name $Feed -Verbose:$VerbosePreference;
     $Uri = $Global:azDevOpsFeed + "_apis/packaging/feeds/$($thisFeed.id)/views?api-version=$($ApiVersion)";
     $thisView = (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value |Where-Object -Property Name -eq $Name;
     $Uri = $Global:azDevOpsFeed + "_apis/packaging/feeds/$($thisFeed.id)/views/$($thisView.id)?api-version=$($ApiVersion)";
     Write-Verbose "GetFeedView       : Specific Org View";
     Write-Verbose " Feed             : $($thisFeed.id)";
     Write-Verbose " View             : $($thisView.id)";
    }
    if (!([string]::IsNullOrEmpty($Feed)) -and !(([string]::IsNullOrEmpty($Project))) -and ([string]::IsNullOrEmpty($Name)))
    {
   	 $thisProject = Get-AdoProject -Verbose:$VerbosePreference | Where-Object -Property Name -eq $Project;
     $thisFeed = Get-AdoFeed -Project $Project -Name $Feed -verbose:$VerbosePreference;
     $Uri = $Global:azDevOpsFeed + "$($thisProject.id)/_apis/packaging/feeds/$($thisFeed.id)/views?api-version=$($ApiVersion)";
     Write-Verbose "GetFeedView       : All Project Views";
     Write-Verbose " Project          : $($thisProject.id)";
     Write-Verbose " Feed             : $($thisFeed.id)";
    }
    if (!([string]::IsNullOrEmpty($Feed)) -and !(([string]::IsNullOrEmpty($Project))) -and !(([string]::IsNullOrEmpty($Name))))
    {
   	 $thisProject = Get-AdoProject -Verbose:$VerbosePreference | Where-Object -Property Name -eq $Project;
     $thisFeed = Get-AdoFeed -Project $Project -Name $Feed -verbose:$VerbosePreference;
     $Uri = $Global:azDevOpsFeed + "$($thisProject.id)/_apis/packaging/feeds/$($thisFeed.id)/views?api-version=$($ApiVersion)";
     $thisView = (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value |Where-Object -Property Name -eq $Name;
     $Uri = $Global:azDevOpsFeed + "$($thisProject.id)/_apis/packaging/feeds/$($thisFeed.id)/views/$($Name)?api-version=$($ApiVersion)";
     Write-Verbose "GetFeedView       : Specific Project View";
     Write-Verbose " Project          : $($thisProject.id)";
     Write-Verbose " Feed             : $($thisFeed.id)";
     Write-Verbose " View             : $($thisView.id)";
    }
    if ($Uri)
    {
     Write-Verbose " Uri              : $($Uri)";
     $Result = (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
     if ($Result.Value)
     {
      return $Result.Value;
     }
     else
     {
      return $Result;
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