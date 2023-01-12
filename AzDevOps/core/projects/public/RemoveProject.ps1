function Remove-Project
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Remove-AzDevOpsProject.md#remove-azdevopsproject',
  PositionalBinding = $true)]
 [OutputType([String])]
 param (
  [Parameter(Mandatory = $true)]
  [object]$Project,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4')]
  [string]$ApiVersion = '7.1-preview.4'
 )
 begin
 {
  try
  {
   Write-Verbose "RemoveProject    : Begin Processing";
   Write-Verbose " ProjectId       : $($Project.Id)";
   Write-Verbose " ApiVersion      : $($ApiVersion)";
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)?api-version=$($ApiVersion)";
    if ($PSCmdlet.ShouldProcess("Remove", "Delete $($Project.Name) from $($Global:azDevOpsOrg) Azure Devops"))
    {
     $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Delete -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference;
    }

    do
    {
     $Status = Get-AzDevOpsOperations -OperationId $Result.id -Verbose:$VerbosePreference;
     Write-Verbose $Status.status;
    } until ($Status.status -eq 'succeeded')
    return "Project $($Project.name) removed";
   }
  }
  catch
  {
   throw $_;
  }
 }
}