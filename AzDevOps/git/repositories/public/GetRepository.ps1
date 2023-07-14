function Get-Repository
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Get-AdoRepository.md#get-adorepository',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [string]$Name,
  [Parameter(Mandatory = $false)]
  [ValidateSet('7.0')]
  [string]$ApiVersion = '7.0'
 )
 begin
 {
  try
  {
   Write-Verbose "GetRepository : Begin Processing";
   if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    Write-Verbose " Project      : $($Project)";
   }
   else
   {
    Write-Verbose " ProjectId    : $($ProjectId)";
   }
   Write-Verbose " Name         : $($Name)";
   Write-Verbose " ApiVersion   : $($ApiVersion)";
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($PSCmdlet.ParameterSetName -eq 'ProjectId')
    {
     $ThisProject = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    if ($PSCmdlet.ParameterSetName -eq 'Project')
    {
     $ThisProject = Get-AdoProject -Verbose:$VerbosePreference |Where-Object -Property Name -eq $Project;
    }
    $Uri = $Global:azDevOpsOrg + "$($ThisProject.Id)/_apis/git/repositories?api-version=$($ApiVersion)";
    if ($Name)
    {
     $Uri = $Global:azDevOpsOrg + "$($ThisProject.Id)/_apis/git/repositories/$($Name)?api-version=$($ApiVersion)";
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
