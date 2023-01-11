function New-BuildFolder {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
      HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/New-AzDevOpsBuildFolder.md#new-azdevopsbuildfolder',
      PositionalBinding = $true)]
    [OutputType([Object])]
    param (
      [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
      [object]$Project,
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [Guid]$ProjectId,
      [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
      [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
      [string]$Name,
      [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
      [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
      [string]$Description
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
          $Body = New-Object -TypeName psobject
          if ($Name) { Add-Member -InputObject $Body -MemberType NoteProperty -Name Path -Value $Name.Replace('\', '/') }
          if ($Description) { Add-Member -InputObject $Body -MemberType NoteProperty -Name Description -Value $Description }
  
          $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/folders?path=$($Name.Replace('\','/'))&api-version=5.1-preview.2"
          if ($PSCmdlet.ShouldProcess("New", "Create Folder $($Name) in $($Project.name) Azure Devops Projects")) {
            Invoke-RestMethod -Uri $uriProjects -Method Put -Headers $Global:azDevOpsHeader -Body ($Body | ConvertTo-Json) -ContentType 'application/json'
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
