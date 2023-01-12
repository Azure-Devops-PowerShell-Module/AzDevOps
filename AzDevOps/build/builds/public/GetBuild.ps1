function Get-Build
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AzDevOpsBuild.md#get-azdevopsbuild',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$BuildId,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7')]
  [string]$ApiVersion = '7.1-preview.7'
 )
 begin
 {
  Write-Verbose "GetBuild    : Begin Processing";
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose " ProjectId  : $($Project.Id)";
  }
  else
  {
   Write-Verbose " ProjectId  : $($ProjectId)";
  }
  Write-Verbose " BuildId    : $($BuildId)";
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
     $Project = Get-AzDevOpsProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds?api-version=$($ApiVersion)";
    if ($BuildId)
    {
     $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds/$($BuildId)?api-version=$($ApiVersion)";
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
