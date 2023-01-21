function New-Repository
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/New-AdoRepository.md#new-adorepository',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Fork')]
  [object]$Project,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Fork')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Fork')]
  [string]$Name,
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Fork')]
  [string]$ParentRepository,
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Fork')]
  [string]$ParentProjectId,
  [Parameter(Mandatory = $false)]
  [ValidateSet('7.0')]
  [string]$ApiVersion = '7.0'
 )
 begin
 {
  try
  {
   Write-Verbose "NewRepository     : Begin Processing";
   Write-Verbose " ParametersetName : $($PSCmdlet.ParameterSetName)";
   if ($Project)
   {
    Write-Verbose " ProjectId        : $($Project.Id)";
   }
   elseif ($ProjectId)
   {
    Write-Verbose " ProjectId        : $($ProjectId)";
   }
   if ($PSCmdlet.ParameterSetName -eq 'Fork')
   {
    Write-Verbose " ParentRepository : $($ParentRepository)";
    Write-Verbose " ParentProjectId  : $($ParentProjectId)";
   }
   else
   {
    Write-Verbose " Name             : $($Name)";
   }
   Write-Verbose " ApiVersion       : $($ApiVersion)";
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($ProjectId)
    {
     $Project = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    $Uri = $Global:azDevOpsOrg + "_apis/git/repositories?api-version=$($ApiVersion)";
    [System.Text.StringBuilder]$stringBuilder = New-Object System.Text.StringBuilder;
    $stringBuilder.AppendLine("{") | Out-Null;
    $stringBuilder.AppendLine(" `"name`": `"$($Name)`",") | Out-Null;
    $stringBuilder.AppendLine(" `"project`" : {") | Out-Null;
    $stringBuilder.AppendLine("  `"id`":`"$($Project.Id)`"") | Out-Null;
    $stringBuilder.AppendLine(" },") | Out-Null;
    $stringBuilder.AppendLine("}") | Out-Null;
    $Body = $stringBuilder.ToString() | ConvertFrom-Json | ConvertTo-Json -Compress;
    if ($PSCmdlet.ParameterSetName -eq 'Fork')
    {
     $Parent = Get-AdoRepository -Project $project -Name $ParentRepository;
     [System.Text.StringBuilder]$stringBuilder = New-Object System.Text.StringBuilder;
     $stringBuilder.AppendLine("{") | Out-Null;
     $stringBuilder.AppendLine(" `"name`": `"$($Name)`",") | Out-Null;
     $stringBuilder.AppendLine(" `"project`" : {") | Out-Null;
     $stringBuilder.AppendLine("  `"id`":`"$($Project.Id)`"") | Out-Null;
     $stringBuilder.AppendLine(" },") | Out-Null;
     $stringBuilder.AppendLine(" `"parentRepository`": {") | Out-Null;
     $stringBuilder.AppendLine("  `"id`": `"$($Parent.id)`",") | Out-Null;
     $stringBuilder.AppendLine("  `"project`": {") | Out-Null;
     if ($ParentProjectId)
     {
      $stringBuilder.AppendLine("   `"id`": `"$($ParentProjectId)`",") | Out-Null;
     }
     else
     {
      $stringBuilder.AppendLine("   `"id`": `"$($Project.Id)`",") | Out-Null;
     }
     $stringBuilder.AppendLine("  }") | Out-Null;
     $stringBuilder.AppendLine(" }") | Out-Null;
     $stringBuilder.AppendLine("}") | Out-Null;
     $Body = $stringBuilder.ToString() | ConvertFrom-Json | ConvertTo-Json -Compress;
    }
    Write-Verbose " Body             : $($Body |Out-String)";
    if ($PSCmdlet.ShouldProcess("New", "Create Folder $($Name) in $($Project.name) Azure Devops Projects"))
    {
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method POST -Headers $Global:azDevOpsHeader -Body ($Body) -ContentType 'application/json' -Verbose:$VerbosePreference);
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}
