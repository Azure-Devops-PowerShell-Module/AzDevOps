function Get-BuildDefinition
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildDefinition.md#get-Adobuilddefinition',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$DefinitionId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$Revision,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7')]
  [string]$ApiVersion = '7.1-preview.7'
 )
 process
 {
  Write-Verbose "GetBuildDefinition : Process Record";
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose " ProjectId         : $($Project.Id)";
  }
  else
  {
   Write-Verbose " ProjectId         : $($ProjectId)";
  }
  Write-Verbose " DefinitionId      : $($DefinitionId)";
  Write-Verbose " Revision          : $($Revision)";
  Write-Verbose " ApiVersion        : $($ApiVersion)";
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
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/definitions?api-version=$($ApiVersion)";
    if ($DefinitionId)
    {
     $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/definitions/$($DefinitionId)";
     if ($Revision)
     {
      $Uri = $Uri + "?revision=$($Revision)&api-version=$($ApiVersion)";
     } else {
      $Uri = $Uri + "?api-version=$($ApiVersion)"
     }
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