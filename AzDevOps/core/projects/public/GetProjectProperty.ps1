function Get-ProjectProperty
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AzDevOpsProjectProperty.md#get-azdevopsprojectproperty',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline)]
  [object]$Project,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.1', '7.1-preview.1')]
  [string]$ApiVersion = '7.1-preview.1'
 )
 begin
 {
  try
  {
   Write-Verbose "GetBuild    : Begin Processing";
   Write-Verbose " ProjectId  : $($Project.Id)";
   Write-Verbose " ApiVersion : $($ApiVersion)";
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/properties?api-version=$($ApiVersion)";
    return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference).Value;
   }
  }
  catch
  {
   throw $_;
  }
 }
}
