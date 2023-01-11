function Get-Project {
    [CmdletBinding(
      HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AzDevOpsProject.md#get-azdevopsproject',
      PositionalBinding = $true)]
      [OutputType([Object])]
    param (
      [Parameter(Mandatory = $false)]
      [Guid]$ProjectId
    )
  
    $ErrorActionPreference = 'Stop'
    $Error.Clear()
  
    try {
      #
      # Are we connected
      #
      if ($Global:azDevOpsConnected) {
        if ($ProjectId) {
          $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($ProjectId)?api-version=5.1"
          return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader)
        }
        else {
          $uriProjects = $Global:azDevOpsOrg + "_apis/projects?api-version=5.1"
          (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value
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
