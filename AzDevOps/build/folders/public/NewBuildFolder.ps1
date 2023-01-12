function New-BuildFolder
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/build/blob/master/docs/New-AzDevOpsBuildFolder.md#new-azdevopsbuildfolder',
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
  [ValidateSet('5.1-preview.2', '7.1-preview.2')]
  [string]$ApiVersion = '7.1-preview.2'
 )
 process
 {
  try
  {
   Write-Verbose "NewBuildFolder : Process Record";
   if ($PSCmdlet.ParameterSetName -eq 'Project')
   {
    Write-Verbose " ProjectId     : $($Project.Id)";
   }
   else
   {
    Write-Verbose " ProjectId     : $($ProjectId)";
   }
   Write-Verbose " Name          : $($Path)";
   Write-Verbose " Description   : $($Path)";
   Write-Verbose " ApiVersion    : $($ApiVersion)";
   $ErrorActionPreference = 'Stop'
   $Error.Clear()
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    if ($PSCmdlet.ParameterSetName -eq 'ProjectId')
    {
     $Project = Get-AzDevOpsProject -ProjectId $ProjectId -Verbose:$VerbosePreference;
    }
    $Body = New-Object -TypeName psobject
    if ($Name) { Add-Member -InputObject $Body -MemberType NoteProperty -Name Path -Value $Name.Replace('\', '/') };
    if ($Description) { Add-Member -InputObject $Body -MemberType NoteProperty -Name Description -Value $Description };
    $Uri = $Global:azDevOpsOrg + "$($Project.Id)/_apis/build/folders?path=$($Name.Replace('\','/'))&api-version=$($ApiVersion)";
    if ($PSCmdlet.ShouldProcess("New", "Create Folder $($Name) in $($Project.name) Azure Devops Projects"))
    {
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method PUT -Headers $Global:azDevOpsHeader -Body ($Body | ConvertTo-Json) -ContentType 'application/json' -Verbose:$VerbosePreference);
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}
