function Remove-BuildFolder
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AzDevOpsBuildFolder.md#remove-azdevopsbuildfolder',
  PositionalBinding = $true)]
 [OutputType([string])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [string]$Name
 )

 process
 {
  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try
  {
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    switch ($PSCmdlet.ParameterSetName)
    {
     'Project'
     {
     }
     'ProjectId'
     {
      $Project = Get-AzDevOpsProject -ProjectId $ProjectId
     }
    }

    $Folder = Get-AzDevOpsBuildFolder -Project $Project -Path $Name

    $uriProjects = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/folders/?api-version=5.0-preview.2&path=$($Folder.Path)"
    if ($PSCmdlet.ShouldProcess("Delete", "Remove Folder $($Name) from $($Project.name) Azure Devops Projects"))
    {
     Invoke-RestMethod -Uri $uriProjects -Method Delete -Headers $Global:azDevOpsHeader
     $Project | Get-AzDevOpsBuildFolder
    }
   }
   else
   {
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
  catch
  {
   throw $_
  }
 }
}