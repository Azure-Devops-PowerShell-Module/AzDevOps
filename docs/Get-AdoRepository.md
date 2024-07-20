---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Get-AdoRepository.md#get-adorepository
schema: 2.0.0
---

# Get-AdoRepository

## SYNOPSIS

Retrieve a git repository.

## SYNTAX

### Project

```powershell
Get-AdoRepository [-Project <Object>] [-Name <String>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ProjectId

```powershell
Get-AdoRepository [-ProjectId <Guid>] [-Name <String>] [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Retrieve a git repository.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-AdoRepository -Project $Project -Name 'my repo'

id              : 7d8deb7b-863a-4ef3-bb75-83b4e6ae369a
name            : my repo
url             : https://dev.azure.com/myorg/44b34ea4-9831-4539-9c9f-925b9533ebf8/_apis/git/repositories/7d8deb7b-863a-4ef3-bb75-83b4e6ae369a
project         : @{id=44b34ea4-9831-4539-9c9f-925b9533ebf8; name=MyProject;
                  url=https://dev.azure.com/myorg/_apis/projects/44b34ea4-9831-4539-9c9f-925b9533ebf8; state=wellFormed; revision=2249; visibility=private;
                  lastUpdateTime=7/19/2024 10:08:11 PM}
size            : 0
remoteUrl       : https://myorg@dev.azure.com/myorg/MyProject/_git/my%20repo
sshUrl          : git@ssh.dev.azure.com:v3/myorg/MyProject/my%20repo
webUrl          : https://dev.azure.com/myorg/MyProject/_git/my%20repo
_links          : @{self=; project=; web=; ssh=; commits=; refs=; pullRequests=; items=; pushes=}
isDisabled      : False
isInMaintenance : False
```

Get a repository

## PARAMETERS

### -ApiVersion

Version of the API to use. This should be set to '7.2-preview.1' to use this version of the api.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: 7.0, 7.2-preview.1

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Name of the repository

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction

{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Project

The Project where the repository is located

```yaml
Type: System.Object
Parameter Sets: Project
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProjectId

The Project Id where the repository is located

```yaml
Type: System.Guid
Parameter Sets: ProjectId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Get-AdoRepository.md#get-adorepository](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Get-AdoRepository.md#get-adorepository)
