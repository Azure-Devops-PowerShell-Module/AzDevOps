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
