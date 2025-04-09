function New-Team
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/teams/blob/master/docs/New-AdoTeam.md#new-adoteam',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $true)]
  [string]$Name,

  [Parameter(Mandatory = $false)]
  [string]$Description,

  [Parameter(ValueFromPipeline)]
  [object]$Project,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.3', '7.1-preview.3', '7.2-preview.3')]
  [string]$ApiVersion = '7.2-preview.3'
 )

 process
 {
  Write-Verbose "NewTeam: Process Record"
  Write-Verbose "Name: $($Name)"
  Write-Verbose "Description: $($Description)"
  Write-Verbose "ProjectId: $($Project.Id)"
  Write-Verbose "ApiVersion: $($ApiVersion)"

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

   $Uri = "$($Global:azDevOpsOrg)_apis/projects/$($Project.Id)/teams/?api-version=$($ApiVersion)"
   Write-Verbose "Uri: $($Uri)"

   if ($PSCmdlet.ShouldProcess("Create", "Create new team in $($Project.Name) Azure DevOps Projects"))
   {
    return Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Post -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json" -Verbose:$VerbosePreference
   }
  }
  catch
  {
   throw $_
  }
 }
}