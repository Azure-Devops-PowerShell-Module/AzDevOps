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
