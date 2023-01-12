function Get-BuildFolder
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AzDevOpsBuildFolder.md#get-azdevopsbuildfolder',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [string]$Path,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.2', '7.1-preview.2')]
  [string]$ApiVersion = '7.1-preview.2'
 )
 process
 {
  try
  {
   Write-Verbose "GetBuildFolder : Begin Processing";
   if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    Write-Verbose " ProjectId     : $($Project.Id)";
   }
   else
   {
    Write-Verbose " ProjectId     : $($ProjectId)";
   }
   Write-Verbose " Path          : $($Path)";
   Write-Verbose " ApiVersion    : $($ApiVersion)";
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
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/folders?api-version=$($ApiVersion)"
    if ($Path)
    {
     $Uri = $Uri + "&path=$($Path.Replace('\','/'))"
    }
    return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
   }
  }
  catch
  {
   throw $_
  }
 }
}
