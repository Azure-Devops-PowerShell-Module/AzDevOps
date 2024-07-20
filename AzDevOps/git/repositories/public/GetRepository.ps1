function Get-Repository
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Get-AdoRepository.md#get-adorepository',
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
  [string]$Name,

  [Parameter(Mandatory = $false)]
  [ValidateSet('7.0', '7.2-preview.1')]
  [string]$ApiVersion = '7.2-preview.1'
 )

 begin
 {
  Write-Verbose "GetRepository: Begin Processing"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project: $($Project)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "Name: $($Name)"
  Write-Verbose "ApiVersion: $($ApiVersion)"
 }

 process
 {
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
    "$($Global:azDevOpsOrg)$($Project.Id)/_apis/git/repositories"
   }
   else
   {
    "$($Global:azDevOpsOrg)$($ProjectId)/_apis/git/repositories"
   }

   $Uri = if ($Name)
   {
    "$($BaseUri)/$($Name)?api-version=$($ApiVersion)"
   }
   else
   {
    "$($BaseUri)?api-version=$($ApiVersion)"
   }

   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($Name)
   {
    return $Response
   }
   else
   {
    return $Response.Value
   }
  }
  catch
  {
   throw $_
  }
 }
}