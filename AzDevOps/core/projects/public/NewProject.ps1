function New-Project
{
 [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low',
  HelpURI = 'https://github.com/Azure-Devops-PowerShell-Module/projects/blob/master/docs/New-AdoProject.md#new-Adoproject',
  PositionalBinding = $true)]
 [OutputType([Object])]
 param (
  [Parameter(Mandatory = $true)]
  [string]$Name,
  [Parameter(Mandatory = $false)]
  [string]$Description,
  [Parameter(Mandatory = $false)]
  [ValidateSet('5.1', '7.1-preview.4')]
  [string]$ApiVersion = '7.1-preview.4'
 )
 begin
 {
  Write-Verbose "NewProject      : Begin Processing";
  Write-Verbose " Name           : $($BuildId)";
  Write-Verbose " Description    : $($BuildId)";
  Write-Verbose " ApiVersion     : $($ApiVersion)";
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
    $Uri = $Global:azDevOpsOrg + "_apis/projects?api-version=$($ApiVersion)";
    if ($PSCmdlet.ShouldProcess("Create", "Create new project in $($Global:azDevOpsOrg) Azure Devops"))
    {
     $Result = Invoke-AdoEndpoint -Uri ([System.Uri]::new($Uri)) -Method POST -Headers $Global:azDevOpsHeader -Body $Body -ContentType "application/json" -Verbose:$VerbosePreference;
    }
    do
    {
     $Status = Get-AdoOperations -OperationId $Result.id -Verbose:$VerbosePreference;
     Write-Verbose $Status.status;
    } until ($Status.status -eq 'succeeded')
    Start-Sleep -Seconds 1;
    Get-AdoProject  -Verbose:$VerbosePreference | Where-Object -Property name -eq $Name;
   }
  }
  catch
  {
   throw $_;
  }
 }
}