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
  [ValidateSet('5.1-preview.3', '7.1-preview.3')]
  [string]$ApiVersion = '7.1-preview.3'
 )
 process
 {
  Write-Verbose "NewTeam      : Process Record";
  Write-Verbose " Name        : $($Name)";
  Write-Verbose " Description : $($Description)";
  Write-Verbose " ProjectId   : $($Project.Id)";
  Write-Verbose " ApiVersion  : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   #
   # Are we connected
   #
   if ($Global:azDevOpsConnected)
   {
    $Body = @{
     "name"        = $Name
     "description" = $Description
    } | ConvertTo-Json -Depth 5 -Compress;
    $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)/teams/?api-version=$($ApiVersion)";
    if ($PSCmdlet.ShouldProcess("Create", "Create new team in $($Project.name) Azure Devops Projects"))
    {
     return (Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method Post -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json" -Verbose:$VerbosePreference);
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}