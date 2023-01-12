function Connect-Organization
{

 [CmdletBinding(
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/core/blob/master/docs/Connect-AzDevOpsOrganization.md#connect-azdevopsOrganization',
  PositionalBinding = $true)]
 [OutputType([String])]
 param (
  [Parameter(Mandatory = $true)]
  [string]$Orgname,
  [Parameter(Mandatory = $true)]
  [string]$PAT,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4')]
  [string]$ApiVersion = '7.1-preview.4'
 )

 begin
 {
  try
  {
   Write-Verbose "ConnectOrganization : Begin Processing"
   Write-Verbose " Orgname            : $($Orgname)"
   Write-Verbose " ApieVersion        : $($ApiVersion)"
   $ErrorActionPreference = 'Stop';
   $Error.Clear();
   $azDevOpsHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($PAT)")) }
   $azDevOpsOrg = "https://dev.azure.com/$($Orgname)/"

   $uriProjects = $azDevOpsOrg + "_apis/projects?api-version=$($ApiVersion)"
   $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($uriProjects)) -Method get -Headers $azDevOpsHeader -Verbose:$VerbosePreference
   if ($Result.GetType().Name -ne 'String')
   {
    Set-Variable -Name azDevOpsHeader -Value $azDevOpsHeader -Scope Global
    Set-Variable -Name azDevOpsOrg -Value $azDevOpsOrg -Scope Global
    Set-Variable -Name azDevOpsConnected -Value $true -Scope Global
    return "Connected to $($azDevOpsOrg)"
   }
  }
  catch
  {
   throw $_;
  }
 }
}
