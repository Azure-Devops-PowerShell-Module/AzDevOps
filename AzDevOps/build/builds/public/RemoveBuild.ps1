function Remove-Build
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Remove-AdoBuild.md#remove-adobuild',
  PositionalBinding = $true)]
 [OutputType([string])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [int]$BuildId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7')]
  [string]$ApiVersion = '7.1-preview.7'
 )

 process
 {
  Write-Verbose "Remove-Build: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project URL: $($Project.url)"
   Write-Verbose "Build ID: $($BuildId)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
   Write-Verbose "BuildId: $($BuildId)"
  }
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
    "$($Global:azDevOpsOrg)$($Project.Id)/_apis/build/builds/$($BuildId)"
   }
   else
   {
    "$($Global:azDevOpsOrg)$($ProjectId)/_apis/build/builds/$($BuildId)"
   }

   $Uri = "$($BaseUri)?api-version=$($ApiVersion)"

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   if ($PSCmdlet.ShouldProcess("Delete", "Remove Build $($BuildId) from Azure DevOps Project"))
   {
    $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Delete -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

    if (-not $Result)
    {
     if ($PSCmdlet.ParameterSetName -eq 'Project')
     {
      return "Build: $($BuildId) removed from Project: $($Project.name)"
     }
     else
     {
      return "Build: $($BuildId) removed from Project ID: $($ProjectId)"
     }
    }
   }
  }
  catch
  {
   Write-Error "Error removing build: $_"
   throw $_
  }
 }
}
