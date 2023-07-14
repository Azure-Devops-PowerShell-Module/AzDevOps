function Connect-Organization
{
 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AdoOrganization.md#connect-adoorganization',
  PositionalBinding = $true)]
 [OutputType([String])]
 param (
  [Parameter(Mandatory = $true)]
  [string]$Orgname,
  [Parameter(Mandatory = $true)]
  [string]$PAT,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4','7.1-preview.1')]
  [string]$ApiVersion = '7.1-preview.4'
 )
 begin
 {
  Write-Verbose "ConnectOrganization : Begin Processing";
  Write-Verbose " Orgname            : $($Orgname)";
  Write-Verbose " ApiVersion         : $($ApiVersion)";
  try
  {
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   $azDevOpsHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PAT)")) };
   $azDevOpsOrg = "https://dev.azure.com/$($Orgname)/";
   $azDevOpsFeed = "https://feeds.dev.azure.com/$($Orgname)";

   $uriProjects = $azDevOpsOrg + "_apis/projects?api-version=$($ApiVersion)";
   $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($uriProjects)) -Method get -Headers $azDevOpsHeader -Verbose:$VerbosePreference;
   if ($Result.GetType().Name -ne 'String')
   {
    Set-Variable -Name azDevOpsHeader -Value $azDevOpsHeader -Scope Global;
    Set-Variable -Name azDevOpsOrg -Value $azDevOpsOrg -Scope Global;
    Set-Variable -Name azDevOpsConnected -Value $true -Scope Global;
    Set-Variable -Name azDevOpsFeed -Value $azDevOpsFeed -Scope Global;
    Write-Verbose " azDevpOpsHeader    : $($azDevOpsHeader)";
    Write-Verbose " azDevpOpsOrg       : $($azDevOpsOrg)";
    Write-Verbose " azDevpOpsConnected : $($azDevOpsConnected)";
    Write-Verbose " azDevpOpsFeed      : $($azDevOpsFeed)";
    return "Connected to $($azDevOpsOrg)";
   }
  }
  catch
  {
   throw $_;
  }
 }
}