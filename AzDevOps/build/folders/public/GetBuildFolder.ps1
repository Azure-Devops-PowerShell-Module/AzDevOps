function Get-BuildFolder
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildFolder.md#get-adobuildfolder',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [string]$Path,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.2', '7.1-preview.2','7.2-preview.2')]
  [string]$ApiVersion = '7.2-preview.2'
 )

 process
 {
  Write-Verbose "Get-BuildFolder: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project URL: $($Project.url)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "Path: $($Path)"
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

   $Uri = "$($BaseUri)?api-version=$($ApiVersion)"
   if ($Path)
   {
    $Uri += "&path=$($Path.Replace('\', '/'))"
   }

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   return $Response.Value
  }
  catch
  {
   throw $_
  }
 }
}
