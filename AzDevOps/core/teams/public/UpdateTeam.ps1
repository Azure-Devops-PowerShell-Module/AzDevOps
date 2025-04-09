function Update-Team
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/Update-AdoTeam.md#update-adoteam',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [string]$Name,

  [Parameter(Mandatory = $false)]
  [string]$Description,

  [Parameter(ValueFromPipeline)]
  [object]$Team,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.3', '7.1-preview.3', '7.2-preview.3')]
  [string]$ApiVersion = '7.2-preview.3'
 )

 begin
 {
  Write-Verbose "UpdateTeam: Begin Processing"
  Write-Verbose "Name: $($Name)"
  Write-Verbose "Description: $($Description)"
  Write-Verbose "TeamId: $($Team.Id)"
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

   $Body = @{
    "name"        = $Name
    "description" = $Description
   } | ConvertTo-Json -Depth 5 -Compress

   $Uri = "$($Global:azDevOpsOrg)_apis/projects/$($Team.projectId)/teams/$($Team.Id)?api-version=$($ApiVersion)"
   Write-Verbose "Uri: $($Uri)"

   if ($PSCmdlet.ShouldProcess("Update", "Update team in Azure DevOps Projects"))
   {
    return Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method PATCH -Body $Body -ContentType "application/json" -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference
   }
  }
  catch
  {
   throw $_
  }
 }
}