function Get-BuildFolder {
    [CmdletBinding(
      HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AzDevOpsBuildFolder.md#get-azdevopsbuildfolder',
      PositionalBinding = $true)]
    [OutputType([Object])]
    param (
      [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
      [object]$Project,
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [Guid]$ProjectId,
      [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [string]$Path,
      [Parameter(Mandatory = $false)]
      [ValidateSet('5.1-preview.2','7.1-preview.2')]
      [string]$ApiVersion = '7.1-preview.2'
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
            'Project' {
            }
            'ProjectId' {
              $Project = Get-AzDevOpsProject -ProjectId $ProjectId
            }
          }
          if ($Path) {
            $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/folders?api-version=$($ApiVersion)&path=$($Path.Replace('\','/'))"
          }
          else {
            $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/folders?api-version=$($ApiVersion)"
          }
          Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader | Select-Object -ExpandProperty Value
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
