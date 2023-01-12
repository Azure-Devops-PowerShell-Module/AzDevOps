function Remove-Build
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AzDevOpsBuild.md#remove-azdevopsbuild',
  PositionalBinding = $true)]
 [OutputType([string])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [int]$BuildId,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7')]
  [string]$ApiVersion = '7.1-preview.7'
 )
 process
 {
  Write-Verbose "RemoveBuild  : Process Record";
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
     $Build = Get-AdoBuild -ProjectId $Project.Id -BuildId $BuildId -Verbose:$VerbosePreference;
    }
    if (!($Build.deleted))
    {
     $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds/$($Build.Id)?api-version=$($ApiVersion)";
     if ($PSCmdlet.ShouldProcess("Delete", "Remove Build $($Build.Id) from $($Project.name) Azure Devops Projects"))
     {
      $Result = (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Delete -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference);
     }
     if (!($Result))
     {
      return "Build : $($Build.id) removed from Project : $($Project.name)"
     }
    }
    else
    {
     return "Build : $($Build.id) was deleted on $(Get-Date ($Build.deletedDate)) by $($Build.deletedBy.displayName)"
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}