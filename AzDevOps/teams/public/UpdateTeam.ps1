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
