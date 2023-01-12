function Get-BuildLog
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AzDevOpsBuildLog.md#get-azdevopsbuildlog',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Build,
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [int]$BuildId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$LogId,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.2')]
  [string]$ApiVersion = '7.1-preview.2'
 )
 process
 {
  Write-Verbose "GetBuildLog  : Process Record";
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose " ProjectID   : $($Project.Id)";
   Write-Verbose " BuildId     : $($Build.Id)";
  }
  else
  {
   Write-Verbose " ProjectID   : $($ProjectId)";
   Write-Verbose " BuildId     : $($BuildId)";
  }
  Write-Verbose " LogId       : $($LogId)";
  Write-Verbose " ApiVersion  : $($ApiVersion)";
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
     $Build = Get-AdoBuild -ProjectId $Project.id -BuildId $BuildId -Verbose:$VerbosePreference;
    }
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds/$($Build.Id)/logs?api-version=$($ApiVersion)";
    if ($LogId)
    {
     $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds/$($Build.Id)/logs/$($LogId)?api-version=$($ApiVersion)";
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
    }
    else
    {
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