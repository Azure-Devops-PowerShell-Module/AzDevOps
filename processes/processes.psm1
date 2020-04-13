# .ExternalHelp processes-help.xml
function Get-Process {
  [CmdletBinding(
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/processes/blob/master/docs/Get-AzDevOpsProcess.md#get-azdevopsprocess',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(Mandatory = $false)]
    [Guid]$ProcessId
  )

  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try {
    #
    # Are we connected
    #
    if ($Global:azDevOpsConnected) {
      if ($ProcessId) {
        $uriProcess = $Global:azDevOpsOrg + "_apis/process/processes/$($ProcessId)?api-version=5.1"
        return (Invoke-RestMethod -Uri $uriProcess -Method get -Headers $Global:azDevOpsHeader)
      }
      else {
        $uriProcess = $Global:azDevOpsOrg + "_apis/process/processes?api-version=5.1"
        (Invoke-RestMethod -Uri $uriProcess -Method get -Headers $Global:azDevOpsHeader).Value
      }
    }
    else {
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
  catch {
    throw $_
  }
}