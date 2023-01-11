function Start-Build
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/Start-AzDevOpsBuild.md#start-azdevopsbuild',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Project,
  [Parameter(ValueFromPipeline, Mandatory = $false, ParameterSetName = 'Project')]
  [object]$Definition,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Guid]$ProjectId,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [int]$DefinitionId,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [hashtable[]]$Variables,
  [Parameter(Mandatory = $false, ParameterSetName = 'ProjectId')]
  [Parameter(Mandatory = $false, ParameterSetName = 'Project')]
  [switch]$Wait
 )

 process
 {
  $ErrorActionPreference = 'Stop'
  $Error.Clear()

  try
  {
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    switch ($PSCmdlet.ParameterSetName)
    {
     'Project'
     {
     }
     'ProjectId'
     {
      $Project = Get-AzDevOpsProject -ProjectId $ProjectId
      $Definition = Get-AzDevOpsBuildDefinition -ProjectId $Project.Id -DefinitionId $DefinitionId
     }
    }
    $uriBuild = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/builds?api-version=5.1"
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
      )
     }
    }
    $Body = New-Object -TypeName psobject
    Add-Member -InputObject $Body -MemberType NoteProperty -Name definition -Value $Definition
    $Parameters = New-Object -TypeName psobject
    foreach ($item in $Variables) { Add-Member -InputObject $parameters -MemberType NoteProperty -Name $item.Keys -Value $item[$item.Keys][0] }
    Add-Member -InputObject $Body -MemberType NoteProperty -Name parameters -Value ($Parameters | ConvertTo-Json -Compress)
    if ($PSCmdlet.ShouldProcess("Start", "Qeue Build $($Build.Id) from $($Project.name) Azure Devops Projects"))
    {
     $Result = Invoke-RestMethod -Method post -Uri $uriBuild -Headers $Global:azDevOpsHeader -ContentType 'application/json' -Body ($Body | ConvertTo-Json -Compress -Depth 10)
     if ($Wait)
     {
      do
      {
       Get-AzDevOpsBuild -Project $Project -BuildId $Result.id | out-null
      } until ((Get-AzDevOpsBuild -Project $Project -BuildId $Result.id).status -eq 'completed')
     }
     return Get-AzDevOpsBuild -Project $Project -BuildId $Result.id
    }
   }
   else
   {
    $PSCmdlet.ThrowTerminatingError(
     [System.Management.Automation.ErrorRecord]::new(
              ([System.Management.Automation.ItemNotFoundException]"Not connected to Azure DevOps, please run Connect-AzDevOpsOrganization"),
      'Projects.Functions',
      [System.Management.Automation.ErrorCategory]::OpenError,
      $MyObject
     )
    )
   }
  }
  catch
  {
   throw $_
  }
 }
}
