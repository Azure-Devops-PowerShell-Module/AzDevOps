function Get-BuildLog
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Get-AdoBuildLog.md#get-adobuildlog',
  PositionalBinding = $true
 )]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Build,

  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [int]$BuildId,

  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$LogId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.2','7.2-preview.2')]
  [string]$ApiVersion = '7.2-preview.2'
 )

 begin
 {
  Write-Verbose "Get-BuildLog: Begin Processing"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project URL: $($Project.url)"
   Write-Verbose "Build ID: $($Build.Id)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
   Write-Verbose "BuildId: $($BuildId)"
  }
  Write-Verbose "LogId: $($LogId)"
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
    $BaseUri = "$($Global:azDevOpsOrg)$($Project.Id)/_apis/build/builds/$($Build.Id)/logs"
    if ($LogId)
    {
     $Uri = "$($BaseUri)/$($LogId)?api-version=$($ApiVersion)"
    }
    else
    {
     $Uri = "$($BaseUri)?api-version=$($ApiVersion)"
    }
   }
   else
   {
    $BaseUri = "$($Global:azDevOpsOrg)$($ProjectId)/_apis/build/builds/$($BuildId)/logs"
    if ($LogId)
    {
     $Uri = "$($BaseUri)/$($LogId)?api-version=$($ApiVersion)"
    }
    else
    {
     $Uri = "$($BaseUri)?api-version=$($ApiVersion)"
    }
   }

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   $Response = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference

   if ($LogId)
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
   Write-Error "Error retrieving build log(s): $_"
   throw $_
  }
 }

 end
 {
  Write-Verbose "Get-BuildLog: End Processing"
 }
}