# .ExternalHelp operations-help.xml
function Get-Operation {
  [CmdletBinding(
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/operations/blob/master/docs/Get-AzDevOpsOperation.md#get-azdevopsoperation',
    PositionalBinding = $true)]
    [OutputType([Object])]
  param (
    [Parameter(Mandatory = $true)]
    [Guid]$OperationId
  )

  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try {
    #
    # Are we connected
    #
    if ($Global:azDevOpsConnected) {
      $uriOperations = $Global:azDevOpsOrg + "_apis/operations/$($OperationId)?api-version=5.1"
      Invoke-RestMethod -Uri $uriOperations -Method Get -Headers $Global:azDevOpsHeader
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