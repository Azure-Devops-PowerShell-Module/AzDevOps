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
  Write-Verbose "StartBuild    : Process Record";
  if ($PSCmdlet.ParameterSetName -eq 'Project')
  {
   Write-Verbose " ProjectID    : $($Project.Id)";
   Write-Verbose " DefinitionId : $($Definition.Id)";
  }
  else
  {
   Write-Verbose " ProjectID    : $($ProjectId)";
   Write-Verbose " DefinitionId : $($DefinitionId)";
  }
  Write-Verbose " Variables    : $([string]::Join(',',$Variables.Keys))";
  Write-Verbose " Wait         : $($Wait)";
  Write-Verbose " ApiVersion   : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($PSCmdlet.ParameterSetName -eq 'ProjectId')
    {
     $Project = Get-AdoProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
     $Definition = Get-AdoBuildDefinition -ProjectId $Project.Id -DefinitionId $DefinitionId -Verbose:$VerbosePreference;
    }
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds?api-version=$($ApiVersion)";
    #
    # Check that variables exist in defintion
    #
    foreach ($key in $Variables.keys)
    {
     if (!($Definition.variables | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name).Contains($key))
     {
      $PSCmdlet.ThrowTerminatingError(
       [System.Management.Automation.ErrorRecord]::new(
                  ([System.Management.Automation.ItemNotFoundException]"One or more variables not found in Build Definition"),
        'Projects.Functions',
        [System.Management.Automation.ErrorCategory]::OpenError,
        $MyObject
       )
      );
     }
    }
    $Body = New-Object -TypeName psobject;
    Add-Member -InputObject $Body -MemberType NoteProperty -Name definition -Value $Definition;
    $Parameters = New-Object -TypeName psobject;
    foreach ($item in $Variables) { Add-Member -InputObject $parameters -MemberType NoteProperty -Name $item.Keys -Value $item[$item.Keys][0] };
    Add-Member -InputObject $Body -MemberType NoteProperty -Name parameters -Value ($Parameters | ConvertTo-Json -Compress);
    if ($PSCmdlet.ShouldProcess("Start", "Qeue Build $($Build.Id) from $($Project.name) Azure Devops Projects"))
    {
     $Result = Invoke-AdoEndpoint -Method POST -Uri ([System.Uri]::new(($Uri))) -Headers $Global:azDevOpsHeader -ContentType 'application/json' -Body ($Body | ConvertTo-Json -Compress -Depth 10) -Verbose:$VerbosePreference;
     if ($Wait)
     {
      do
      {
       Get-AdoBuild -Project $Project -BuildId $Result.id | out-null;
      } until ((Get-AdoBuild -Project $Project -BuildId $Result.id -Verbose:$VerbosePreference).status -eq 'completed')
     }
     return Get-AdoBuild -Project $Project -BuildId $Result.id -Verbose:$VerbosePreference;
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}