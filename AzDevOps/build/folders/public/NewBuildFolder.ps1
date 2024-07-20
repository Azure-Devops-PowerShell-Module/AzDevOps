function New-BuildFolder
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/New-AdoBuildFolder.md#new-adobuildfolder',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $true, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [string]$Name,

  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [string]$Description,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1-preview.2', '7.1-preview.2','7.2-preview.2')]
  [string]$ApiVersion = '7.2-preview.2'
 )

 process
 {
  Write-Verbose "NewBuildFolder: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "ProjectId: $($Project.Id)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
  }
  Write-Verbose "Name: $($Name)"
  Write-Verbose "Description: $($Description)"
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

   $Uri = "$($BaseUri)?path=$($Name.Replace('\', '/'))&api-version=$($ApiVersion)"

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   $Body = [PSCustomObject]@{}
   if ($Name) { $Body | Add-Member -MemberType NoteProperty -Name Path -Value $($Name.Replace('\', '/')) }
   if ($Description) { $Body | Add-Member -MemberType NoteProperty -Name Description -Value $($Description) }

   if ($PSCmdlet.ShouldProcess("New", "Create Folder $($Name) in $($Project.name) Azure DevOps Projects"))
   {
    return Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method PUT -Headers $Global:azDevOpsHeader -Body ($Body | ConvertTo-Json) -ContentType 'application/json' -Verbose:$VerbosePreference
   }
  }
  catch
  {
   throw $_
  }
 }
}