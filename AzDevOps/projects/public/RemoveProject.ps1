function Remove-Project
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Remove-AzDevOpsProject.md#remove-azdevopsproject',
  PositionalBinding = $true)]
 [OutputType([String])]
 param (
  [Parameter(Mandatory = $true)]
  [object]$Project
 )

 $ErrorActionPreference = 'Stop'
 $Error.Clear()

 try
 {
  #
  # Are we connected
  #
  if ($Global:azDevOpsConnected)
  {
   $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)?api-version=5.1"
   if ($PSCmdlet.ShouldProcess("Remove", "Delete $($Project.Name) from $($Global:azDevOpsOrg) Azure Devops"))
   {
    $Result = Invoke-RestMethod -Uri $uriProjects -Method Delete -Headers $Global:azDevOpsHeader
   }

   do
   {
    $Status = Get-AzDevOpsOperations -OperationId $Result.id
    Write-Verbose $Status.status
   } until ($Status.status -eq 'succeeded')

   return "Project $($Project.name) removed"
  }
  else
  {
   $PSCmdlet.ThrowTerminatingError(
    [System.Management.Automation.ErrorRecord]::new(
            ([System.Management.Automation.ItemNotFoundException]"Not connected to Azure DevOps, please run Connect-AzDevOpsOrganization"),
     'Projects.Functions',
     [System.Management.Automation.ErrorCategory]::OpenError,
     $MyObject
    )
   )
  }
 }
 catch
 {
  throw $_
 }
}