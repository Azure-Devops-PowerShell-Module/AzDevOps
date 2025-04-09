function Remove-Project
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Remove-AdoProject.md#remove-Adoproject',
  PositionalBinding = $true)]
 [OutputType([String])]
 param (
  [Parameter(Mandatory = $true)]
  [object]$Project,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4', '7.2-preview.4')]
  [string]$ApiVersion = '7.2-preview.4'
 )

 begin
 {
  Write-Verbose "RemoveProject: Begin Processing"
  Write-Verbose "ProjectId: $($Project.Id)"
  Write-Verbose "ApiVersion: $($ApiVersion)"
 }

 process
 {
  try
  {
   $ErrorActionPreference = 'Stop'
   $Error.Clear()

   if (-not $Global:azDevOpsConnected)
   {
    throw "Not connected to Azure DevOps. Please connect using Connect-AdoOrganization."
   }

   $Uri = "$($Global:azDevOpsOrg)_apis/projects/$($Project.Id)?api-version=$($ApiVersion)"
   Write-Verbose "Uri: $($Uri)"

   if ($PSCmdlet.ShouldProcess("Remove", "Delete $($Project.Name) from $($Global:azDevOpsOrg) Azure DevOps"))
   {
    $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Delete -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference
   }

   do
   {
    $Status = Get-AdoOperation -OperationId $Result.id -Verbose:$VerbosePreference
    Write-Verbose "Status: $($Status.status)"
    Start-Sleep -Seconds 1
   } until ($Status.status -eq 'succeeded')

   return "Project $($Project.Name) removed"
  }
  catch
  {
   throw $_
  }
 }
}