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
function Get-ProjectProperty {
  [CmdletBinding(
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AzDevOpsProjectProperty.md#get-azdevopsprojectproperty',
    PositionalBinding = $true)]
    [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline)]
    [object]$Project
  )

  process {
    $ErrorActionPreference = 'Stop'
    $Error.Clear()

    try {
      #
      # Are we connected
      #
      if ($Global:azDevOpsConnected) {
        $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/properties?api-version=5.1-preview.1"
        (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value
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
function New-Project {
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

  try {
    #
    # Are we connected
    #
    if ($Global:azDevOpsConnected) {
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
      if ($PSCmdlet.ShouldProcess("Create", "Create new project in $($Global:azDevOpsOrg) Azure Devops")) {
        $Result = Invoke-RestMethod -Uri $uriProjects -Method Post -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json"
      }

      do {
        $Status = Get-AzDevOpsOperations -OperationId $Result.id
        Write-Verbose $Status.status
      } until ($Status.status -eq 'succeeded')

      Start-Sleep -Seconds 1
      Get-AzDevOpsProject | Where-Object -Property name -eq $Name
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
function Update-Project {
  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium',
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Update-AzDevOpsProject.md#update-azdevopsproject',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(Mandatory = $false)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$Description,
    [Parameter(Mandatory = $true)]
    [object]$Project
  )

  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try {
    #
    # Are we connected
    #
    if ($Global:azDevOpsConnected) {
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

      $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)?api-version=5.1"
      if ($PSCmdlet.ShouldProcess("Modify", "Update $($Project.Name) values")) {
        Invoke-RestMethod -Uri $uriProjects -Method Patch -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json"
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
function Remove-Project {
  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Remove-AzDevOpsProject.md#remove-azdevopsproject',
    PositionalBinding = $true)]
  [OutputType([String])]
  param (
    [Parameter(Mandatory = $true)]
    [object]$Project
  )

  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try {
    #
    # Are we connected
    #
    if ($Global:azDevOpsConnected) {
      $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)?api-version=5.1"
      if ($PSCmdlet.ShouldProcess("Remove", "Delete $($Project.Name) from $($Global:azDevOpsOrg) Azure Devops")) {
        $Result = Invoke-RestMethod -Uri $uriProjects -Method Delete -Headers $Global:azDevOpsHeader
      }

      do {
        $Status = Get-AzDevOpsOperations -OperationId $Result.id
        Write-Verbose $Status.status
      } until ($Status.status -eq 'succeeded')

      return "Project $($Project.name) removed"
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