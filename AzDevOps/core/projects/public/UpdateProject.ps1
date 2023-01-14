function Update-Project
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/Update-AdoProject.md#update-adoproject',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $false)]
  [string]$Name,
  [Parameter(Mandatory = $false)]
  [string]$Description,
  [Parameter(Mandatory = $true)]
  [object]$Project,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4')]
  [string]$ApiVersion = '7.1-preview.4'
 )
 begin
 {
  Write-Verbose "UpdateProject : Begin Processing";
  Write-Verbose " Name         : $($Name)";
  Write-Verbose " Description  : $($Description)";
  Write-Verbose " ProjectId    : $($Project.Id)";
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
    $Body = @{
     "name"         = $Name
     "description"  = $Description
     "capabilities" = @{
      "versioncontrol"  = @{
       "sourceControlType" = "Git"
      }
      "processTemplate" = @{
       "templateTypeId" = "b8a3a935-7e91-48b8-a94c-606d37c3e9f2"
      }
     }
    } | ConvertTo-Json -Depth 5 -Compress;
    $Uri = $Global:azDevOpsOrg + "_apis/projects/$($Project.id)?api-version=$($ApiVersion)";
    if ($PSCmdlet.ShouldProcess("Modify", "Update $($Project.Name) values"))
    {
     Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method PATCH -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json" -Verbose:$VerbosePreference;
    }
   }
  }
  catch
  {
   throw $_;
  }
 }
}