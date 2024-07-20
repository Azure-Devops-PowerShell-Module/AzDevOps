function Get-BuildDefinition
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildDefinition.md#get-Adobuilddefinition',
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
  [int]$DefinitionId,

  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$Revision,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7','7.2-preview.7')]
  [string]$ApiVersion = '7.2-preview.7'
 )

 process
 {
  Write-Verbose "Get-BuildDefinition: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project URL: $($Project.url)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "DefinitionId: $($DefinitionId)"
  Write-Verbose "Revision: $($Revision)"
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
    "$($Global:azDevOpsOrg)$($Project.Id)/_apis/build/definitions"
   }
   else
   {
    "$($Global:azDevOpsOrg)$($ProjectId)/_apis/build/definitions"
   }

   if ($DefinitionId)
   {
    $Uri = "$($BaseUri)/$($DefinitionId)"
    if ($Revision)
    {
     $Uri += "?revision=$($Revision)&api-version=$($ApiVersion)"
    }
    else
    {
     $Uri += "?api-version=$($ApiVersion)"
    }
   }
   else
   {
    $Uri = "$($BaseUri)?api-version=$($ApiVersion)"
   }

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($DefinitionId)
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