function Remove-BuildFolder
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AdoBuildFolder.md#remove-adobuildfolder',
  PositionalBinding = $true)]
 [OutputType([string])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [string]$Name,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.0-preview.2', '7.1-preview.2', '7.2-preview.2')]
  [string]$ApiVersion = '7.2-preview.2'
 )

 process
 {
  Write-Verbose "RemoveBuildFolder: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "ProjectId: $($Project.Id)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "Name: $($Name)"
  Write-Verbose "ApiVersion: $($ApiVersion)"

  try
  {
   $ErrorActionPreference = 'Stop'
   $Error.Clear()

   if (-not $Global:azDevOpsConnected)
   {
    throw "Not connected to Azure DevOps. Please connect using Connect-AzDevOps."
   }

   $BaseUri = if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    "$($Global:azDevOpsOrg)$($Project.Id)/_apis/build/folders"
   }
   else
   {
    "$($Global:azDevOpsOrg)$($ProjectId)/_apis/build/folders"
   }

   $Uri = "$($BaseUri)?api-version=$($ApiVersion)&path=$($Name.Replace('\', '/'))"

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   if ($PSCmdlet.ShouldProcess("Delete", "Remove Folder $($Name) from $($Project.name) Azure DevOps Projects"))
   {
    Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method DELETE -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference
    Write-Output "Folder $($Name) removed from project $($Project.name)"
   }
  }
  catch
  {
   throw $_
  }
 }
}