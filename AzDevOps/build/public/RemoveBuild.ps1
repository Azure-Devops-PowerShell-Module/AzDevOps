function Remove-Build {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
      HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AzDevOpsBuild.md#remove-azdevopsbuild',
      PositionalBinding = $true)]
    [OutputType([string])]
    param (
      [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
      [object]$Project,
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [Guid]$ProjectId,
      [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
      [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
      [int]$BuildId
    )
  
    process {
      $ErrorActionPreference = 'Stop'
      $Error.Clear()
  
      try {
        #
        # Are we connected
        #
        if ($Global:azDevOpsConnected) {
          switch ($PSCmdlet.ParameterSetName) {
            'ProjectId' {
              $Project = Get-AzDevOpsProject -ProjectId $ProjectId
            }
          }
          $Build = Get-AzDevOpsBuild -ProjectId $Project.Id -BuildId $BuildId
          if (!($Build.deleted)) {
            $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds/$($Build.Id)?api-version=5.1"
            if ($PSCmdlet.ShouldProcess("Delete", "Remove Build $($Build.Id) from $($Project.name) Azure Devops Projects")) {
              $Result = Invoke-RestMethod -Uri $uriProjects -Method Delete -Headers $Global:azDevOpsHeader
            }
            if (!($Result)) {
              return "Build : $($Build.id) removed from Project : $($Project.name)"
            }
          }
          else {
            return "Build : $($Build.id) was deleted on $(Get-Date ($Build.deletedDate)) by $($Build.deletedBy.displayName)"
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
  }
