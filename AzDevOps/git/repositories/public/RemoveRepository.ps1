function Remove-Repository
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Remove-AdoRepository.md#remove-adorepository',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Repository,

  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [string]$RepositoryId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('7.0', '7.2-preview.1')]
  [string]$ApiVersion = '7.2-preview.1'
 )

 begin
 {
  Write-Verbose "RemoveRepository: Begin Processing"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "ProjectId: $($Project.Id)"
   Write-Verbose "RepositoryId: $($Repository.Id)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
   Write-Verbose "RepositoryId: $($RepositoryId)"
  }
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

   if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    $ProjectIdToUse = $Project.Id
    $RepositoryIdToUse = $Repository.id
   }
   else
   {
    $ProjectIdToUse = $ProjectId
    $RepositoryIdToUse = $RepositoryId
   }

   $Uri = "$($Global:azDevOpsOrg)$($ProjectIdToUse)/_apis/git/repositories/$($RepositoryIdToUse)?api-version=$($ApiVersion)"
   Write-Verbose "Uri: $($Uri)"

   return Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method DELETE -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference
  }
  catch
  {
   throw $_
  }
 }
}