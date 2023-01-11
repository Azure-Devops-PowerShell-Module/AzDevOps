function New-Project
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/New-AzDevOpsProject.md#new-azdevopsproject',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $true)]
  [string]$Name,
  [Parameter(Mandatory = $false)]
  [string]$Description
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
   $Body = @{
    "name"         = $Name
    "description"  = $Description
    "capabilities" = @{
     "versioncontrol"  = @{
      "sourceControlType" = "Git"
     }
     "processTemplate" = @{
      "templateTypeId" = "b8a3a935-7e91-48b8-a94c-606d37c3e9f2"
     }
    }
   } | ConvertTo-Json -Depth 5

   $uriProjects = $Global:azDevOpsOrg + "_apis/projects?api-version=5.1"
   if ($PSCmdlet.ShouldProcess("Create", "Create new project in $($Global:azDevOpsOrg) Azure Devops"))
   {
    $Result = Invoke-RestMethod -Uri $uriProjects -Method Post -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json"
   }

   do
   {
    $Status = Get-AzDevOpsOperations -OperationId $Result.id
    Write-Verbose $Status.status
   } until ($Status.status -eq 'succeeded')

   Start-Sleep -Seconds 1
   Get-AzDevOpsProject | Where-Object -Property name -eq $Name
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
