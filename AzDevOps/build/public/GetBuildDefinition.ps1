function Get-BuildDefinition {
    [CmdletBinding(
      HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AzDevOpsBuildDefinition.md#get-azdevopsbuilddefinition',
      PositionalBinding = $true)]
    [OutputType([Object])]
    param (
      [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
      [object]$Project,
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [Guid]$ProjectId,
      [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [int]$DefinitionId,
      [Parameter(Mandatory = $false)]
      [ValidateSet('5.1','7.1-preview.7')]
      [string]$ApiVersion = '7.1-preview.7'
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
              $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/definitions?api-version=$($ApiVersion)"
            }
            'ProjectId' {
              $Project = Get-AzDevOpsProject -ProjectId $ProjectId
              $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/definitions?api-version=$($ApiVersion)"
            }
          }
          if ($DefinitionId) {
            $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/definitions/$($DefinitionId)?api-version=$($ApiVersion)"
            return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader)
          }
          else {
            return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value
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
