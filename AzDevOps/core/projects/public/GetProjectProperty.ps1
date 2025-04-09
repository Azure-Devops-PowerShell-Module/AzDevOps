function Get-ProjectProperty
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Get-AdoProjectProperty.md#get-adoprojectproperty',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline)]
  [object]$Project,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.1', '7.1-preview.1', '7.2-preview.1')]
  [string]$ApiVersion = '7.2-preview.1'
 )

 begin
 {
  Write-Verbose "GetBuild: Begin Processing"
  Write-Verbose "ProjectId: $($Project.Id)"
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
    throw "Not connected to Azure DevOps. Please connect using Connect-AdoOrganization."
   }

   $Uri = "$($Global:azDevOpsOrg)_apis/projects/$($Project.Id)/properties?api-version=$($ApiVersion)"
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