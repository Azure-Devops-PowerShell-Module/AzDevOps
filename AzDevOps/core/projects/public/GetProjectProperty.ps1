function Get-ProjectProperty
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AzDevOpsProjectProperty.md#get-azdevopsprojectproperty',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline)]
  [object]$Project
 )

 process
 {
  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try
  {
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/properties?api-version=5.1-preview.1"
          (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value
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
}
