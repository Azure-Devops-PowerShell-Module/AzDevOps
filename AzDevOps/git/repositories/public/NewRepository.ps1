function New-Repository
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/New-AdoRepository.md#new-adorepository',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Repo')]
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Fork')]
  [object]$Project,

  [Parameter(Mandatory = $true, ParameterSetName = 'Repo')]
  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Fork')]
  [string]$Name,

  [Parameter(ValueFromPipeline, Mandatory = $true, ParameterSetName = 'Fork')]
  [string]$ParentRepositoryId,

  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Fork')]
  [string]$ParentProjectId,

  [Parameter(Mandatory = $false)]
  [ValidateSet('7.0', '7.2-preview.1')]
  [string]$ApiVersion = '7.2-preview.1'
 )

 begin
 {
  try
  {
   Write-Verbose "NewRepository: Begin Processing"
   Write-Verbose "ParameterSetName: $($PSCmdlet.ParameterSetName)"
   Write-Verbose "ProjectId: $($Project.Id)"
   if ($PSCmdlet.ParameterSetName -eq 'Fork')
   {
    Write-Verbose "ParentRepositoryId: $($ParentRepositoryId)"
    Write-Verbose "ParentProjectId: $($ParentProjectId)"
   }
   else
   {
    Write-Verbose "Name: $($Name)"
   }
   Write-Verbose "ApiVersion: $($ApiVersion)"
   $ErrorActionPreference = 'Stop'
   $Error.Clear()

   if (-not $Global:azDevOpsConnected)
   {
    throw "Not connected to Azure DevOps. Please connect using Connect-AzDevOps."
   }

   $Uri = "$($Global:azDevOpsOrg)_apis/git/repositories?api-version=$($ApiVersion)"

   switch ($PSCmdlet.ParameterSetName)
   {
    'Repo'
    {
     [System.Text.StringBuilder]$stringBuilder = New-Object System.Text.StringBuilder
     $stringBuilder.AppendLine("{") | Out-Null
     $stringBuilder.AppendLine("  `"name`": `"$($Name)`",") | Out-Null
     $stringBuilder.AppendLine("  `"project`": {") | Out-Null
     $stringBuilder.AppendLine("    `"id`": `"$($Project.Id)`"") | Out-Null
     $stringBuilder.AppendLine("  }") | Out-Null
     $stringBuilder.AppendLine("}") | Out-Null
     $Body = $stringBuilder.ToString() | ConvertFrom-Json | ConvertTo-Json -Compress
    }
    'Fork'
    {
     $ParentUri = "$($Global:azDevOpsOrg)_apis/git/repositories/$($ParentRepositoryId)?api-version=$($ApiVersion)"
     $Parent = (Invoke-AdoEndpoint -Uri ([System.Uri]::new($ParentUri)) -Method Get -Headers $Global:azDevOpsHeader -Verbose:$VerbosePreference)
     [System.Text.StringBuilder]$stringBuilder = New-Object System.Text.StringBuilder
     $stringBuilder.AppendLine("{") | Out-Null
     $stringBuilder.AppendLine("  `"name`": `"$($Name)`",") | Out-Null
     $stringBuilder.AppendLine("  `"project`": {") | Out-Null
     $stringBuilder.AppendLine("    `"id`": `"$($Project.Id)`"") | Out-Null
     $stringBuilder.AppendLine("  },") | Out-Null
     $stringBuilder.AppendLine("  `"ParentRepositoryId`": {") | Out-Null
     $stringBuilder.AppendLine("    `"id`": `"$($Parent.id)`",") | Out-Null
     $stringBuilder.AppendLine("    `"project`": {") | Out-Null
     if ($ParentProjectId)
     {
      $stringBuilder.AppendLine("      `"id`": `"$($ParentProjectId)`",") | Out-Null
     }
     else
     {
      $stringBuilder.AppendLine("      `"id`": `"$($Project.Id)`",") | Out-Null
     }
     $stringBuilder.AppendLine("    }") | Out-Null
     $stringBuilder.AppendLine("  }") | Out-Null
     $stringBuilder.AppendLine("}") | Out-Null
     $Body = $stringBuilder.ToString() | ConvertFrom-Json | ConvertTo-Json -Compress
    }
   }

   Write-Verbose "Body: $($Body | Out-String)"
   if ($PSCmdlet.ShouldProcess("New", "Create repository $($Name) in $($Project.Name) Azure DevOps Projects"))
   {
    return Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method POST -Headers $Global:azDevOpsHeader -Body $Body -ContentType 'application/json' -Verbose:$VerbosePreference
   }
  }
  catch
  {
   throw $_
  }
 }
}