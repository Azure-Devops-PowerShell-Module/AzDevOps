function Get-Team {
  [CmdletBinding(
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AzDevOpsTeam.md#get-azdevopsteam',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
    [object]$Project,
    [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
    [Guid]$ProjectId,
    [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
    [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
    [Guid]$TeamId
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
            if ($TeamId) {
              $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($TeamId)?api-version=5.1"
              return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader)  
            }
            else {
              $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/?api-version=5.1"
              return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value
            }
          }
          'ProjectId' {
            $Project = Get-AzDevOpsProject -ProjectId $ProjectId
            if ($TeamId) {
              $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($TeamId)?api-version=5.1"
              return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader)  
            }
            else {
              $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/?api-version=5.1"
              return (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value
            }
          }
          default {
            $uriTeam = $Global:azDevOpsOrg + "_apis/teams?api-version=5.1-preview.3"
            (Invoke-RestMethod -Uri $uriTeam -Method get -Headers $Global:azDevOpsHeader).Value  
          }
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
function New-Team {
  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/New-AzDevOpsTeam.md#new-azdevopsteam',
    PositionalBinding = $true)]
  [OutputType([Object])]    
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$Description,
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
        $Body = @{
          "name"        = $Name
          "description" = $Description
        } | ConvertTo-Json -Depth 5
  
        $uriTeam = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/?api-version=5.1"
        if ($PSCmdlet.ShouldProcess("Create", "Create new team in $($Project.name) Azure Devops Projects")) {
          return Invoke-RestMethod -Uri $uriTeam -Method Post -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json"
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
function Remove-Team {
  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Remove-AzDevOpsTeam.md#remove-azdevopsteam',
    PositionalBinding = $true)]
  [OutputType([string])]
  param (
    [Parameter(Mandatory = $true)]
    [Guid]$ProjectId,
    [Parameter(Mandatory = $true)]
    [Guid]$TeamId
  )

  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try {
    #
    # Are we connected
    #
    if ($Global:azDevOpsConnected) {
      $Project = Get-AzDevOpsProject -ProjectId $ProjectId
      $Team = Get-AzDevOpsTeam -ProjectId $ProjectId -TeamId $TeamId

      $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)?api-version=5.1"
      if ($PSCmdlet.ShouldProcess("Delete", "Remove team $($Team.name) from $($Project.name) Azure Devops Projects")) {
        $Result = Invoke-RestMethod -Uri $uriProjects -Method Delete -Headers $Global:azDevOpsHeader
        if (!($Result)) {
          return "Team : $($Team.id) removed from Project : $($Project.id)"
        }  
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
function Update-Team {
  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Update-AzDevOpsTeam.md#update-azdevopsteam',
    PositionalBinding = $true)]
  [OutputType([Object])]    
  param (
    [Parameter(Mandatory = $false)]
    [string]$Name,
    [Parameter(Mandatory = $false)]
    [string]$Description,
    [Parameter(ValueFromPipeline)]
    [object]$Team
  )

  process {
    $ErrorActionPreference = 'Stop'
    $Error.Clear()
  
    try {
      #
      # Are we connected
      #
      if ($Global:azDevOpsConnected) {
        $Body = @{
          "name"        = $Name
          "description" = $Description
        } | ConvertTo-Json -Depth 5
  
        $uriTeam = $Global:azDevOpsOrg + "_apis/projects/$($Team.projectid)/teams/$($Team.id)?api-version=5.1"
        if ($PSCmdlet.ShouldProcess("Update", "Update new team in $($Project.name) Azure Devops Projects")) {
          return Invoke-RestMethod -Uri $uriTeam -Method Patch -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json"
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
function Get-TeamMember {
  [CmdletBinding(
    HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Get-AzDevOpsTeamMember.md#get-azdevopsteammember',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
    [object]$Project,
    [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
    [Guid]$ProjectId,
    [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
    [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
    [Guid]$TeamId
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
            if ($TeamId) {
              $Team = Get-AzDevOpsTeam -ProjectId $Project.Id -TeamId $TeamId
              $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)/members?api-version=5.1"
              return ((Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity)
            }
            else {
              foreach ($Team in Get-AzDevOpsTeam -ProjectId $Project.Id) {
                $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($Team.id)/members?api-version=5.1"
                (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity
              }                  
            }
          }
          'ProjectId' {
            $Project = Get-AzDevOpsProject -ProjectId $ProjectId
            if ($TeamId) {
              $Team = Get-AzDevOpsTeam -ProjectId $Project.Id -TeamId $TeamId
              $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/$($Team.id)/members?api-version=5.1"
              return ((Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity)
            }
            else {
              foreach ($Team in Get-AzDevOpsTeam -ProjectId $Project.Id) {
                $uriProjects = $Global:azDevOpsOrg + "_apis/projects/$($Project.Id)/teams/$($Team.id)/members?api-version=5.1"
                (Invoke-RestMethod -Uri $uriProjects -Method get -Headers $Global:azDevOpsHeader).Value | Select-Object -ExpandProperty Identity
              }                  
            }
          }
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