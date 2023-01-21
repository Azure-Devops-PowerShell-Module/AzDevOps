function Remove-Repository
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Remove-AdoRepository.md#remove-adorepository',
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
   Write-Verbose "RemoveRepository : Begin Processing";
   if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    Write-Verbose " ProjectId    : $($Project.Id)";
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
     $Project = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    $Repository = Get-AdoRepository -Project $Project -Name $Name;
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/git/repositories/$($Repository.id)?api-version=$($ApiVersion)";
    return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method DELETE -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
   }
  }
  catch
  {
   throw $_;
  }
 }
}
