function Start-Build
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Start-AdoBuild.md#start-adobuild',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Project,

  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Project')]
  [object]$Definition,

  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,

  [Parameter(Mandatory = $true, ParameterSetName = 'ProjectId')]
  [int]$DefinitionId,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [hashtable[]]$Variables,

  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [switch]$Wait,

  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.7')]
  [string]$ApiVersion = '7.1-preview.7'
 )

 process
 {
  Write-Verbose "StartBuild: Process Record"
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose "Project URL: $($Project.url)"
   Write-Verbose "Definition ID: $($Definition.Id)"
  }
  else
  {
   Write-Verbose "ProjectId: $($ProjectId)"
   Write-Verbose "DefinitionId: $($DefinitionId)"
  }
  if ($Variables)
  {
   Write-Verbose "Variables: $([string]::Join(',', $Variables.Keys))"
  }
  Write-Verbose "Wait: $($Wait)"
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
    "$($Global:azDevOpsOrg)$($Project.Id)/_apis/build/builds"
   }
   else
   {
    "$($Global:azDevOpsOrg)$($ProjectId)/_apis/build/builds"
   }

   $Uri = "$($BaseUri)?api-version=$($ApiVersion)"

   Write-Verbose "BaseUri: $($BaseUri)"
   Write-Verbose "Uri: $($Uri)"

   if ($Variables)
   {
    # Check that variables exist in definition
    foreach ($key in $Variables.keys)
    {
     if (!($Definition.variables | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name).Contains($key))
     {
      $PSCmdlet.ThrowTerminatingError(
       [System.Management.Automation.ErrorRecord]::new(
        ([System.Management.Automation.ItemNotFoundException] "One or more variables not found in Build Definition"),
        'Projects.Functions',
        [System.Management.Automation.ErrorCategory]::OpenError,
        $MyInvocation
       )
      )
     }
    }
   }

   $Body = New-Object -TypeName psobject -Property @{
    definition = (New-Object -TypeName psobject -Property @{ id = $Definition.id })
   }

   if ($Variables)
   {
    $Parameters = [PSCustomObject]@{}
    foreach ($item in $Variables)
    {
     $Parameters | Add-Member -MemberType NoteProperty -Name $item.Keys -Value $item[$item.Keys][0]
    }
    $Body | Add-Member -MemberType NoteProperty -Name parameters -Value ($Parameters | ConvertTo-Json -Compress)
   }

   if ($PSCmdlet.ShouldProcess("Start", "Queue Build $($Definition.Id) from $($Project.name) Azure DevOps Projects"))
   {
    Write-Verbose "Body: $($Body |ConvertTo-Json -Depth 99 -Compress)"
    $Result = Invoke-AdoEndpoint -Method POST -Uri ([System.Uri]::new($Uri)) -Headers $Global:azDevOpsHeader -ContentType 'application/json' -Body ($Body | ConvertTo-Json -Compress -Depth 10) -Verbose:$VerbosePreference

    if ($Wait)
    {
     do
     {
      Start-Sleep -Seconds 5
      $BuildStatus = (Get-AdoBuild -Project $Project -BuildId $Result.id -Verbose:$VerbosePreference).status
     } until ($BuildStatus -eq 'completed')
    }

    return Get-AdoBuild -Project $Project -BuildId $Result.id -Verbose:$VerbosePreference
   }
  }
  catch
  {
   throw $_
  }
 }
}
