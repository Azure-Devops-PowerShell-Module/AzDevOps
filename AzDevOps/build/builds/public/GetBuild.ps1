function Get-Build
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuild.md#get-adobuild',
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
  [int]$BuildId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7', '7.2-preview.7')]
  [string]$ApiVersion = '7.2-preview.7'
 )

 begin
 {
  Write-Verbose "Get-AdoBuild: Begin Processing"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project URL: $($Project.url)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "BuildId: $($BuildId)"
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
    "$($Global:azDevOpsOrg)$($Project.Id)/_apis/build/builds"
   }
   else
   {
    "$($Global:azDevOpsOrg)$($ProjectId)/_apis/build/builds"
   }

   Write-Verbose "BaseUri: $BaseUri"

   $Uri = if ($BuildId)
   {
    "$BaseUri/$BuildId?api-version=$ApiVersion"
   }
   else
   {
    "$BaseUri?api-version=$ApiVersion"
   }

   Write-Verbose "Uri: $Uri"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($BuildId)
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
   Write-Error "Error retrieving build(s): $_"
   throw $_
  }
 }

 end
 {
  Write-Verbose "Get-AdoBuild: End Processing"
 }
}