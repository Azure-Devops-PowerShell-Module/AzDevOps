---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/New-AdoRepository.md#new-adorepository
schema: 2.0.0
---

# New-AdoRepository

## SYNOPSIS

Create a git repository in a team project.

## SYNTAX

### Fork

```powershell
New-AdoRepository -Project <Object> -Name <String> -ParentRepositoryId <String> [-ParentProjectId <String>]
 [-ApiVersion <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Repo

```powershell
New-AdoRepository -Project <Object> -Name <String> [-ApiVersion <String>] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Create a git repository in a team project.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-AdoRepository -Project $Project -Name 'my repo' -Verbose
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
isDisabled      : False
isInMaintenance : False
```

Create a new repository inside your project

### Example 2

```powershell
PS C:\> New-AdoRepository -Project $Project -Name 'my forked repo' -ParentRepository 'ad319ad2-9eea-4c36-abca-cdcaebf41e91' -Verbose
id              : 3b0b9d6c-6ad4-41c4-a1d6-6668cd7515d5
name            : my forked repo
url             : https://dev.azure.com/myorg/44b34ea4-9831-4539-9c9f-925b9533ebf8/_apis/git/repositories/3b0b9d6c-6ad4-41c4-a1d6-6668cd7515d5
project         : @{id=44b34ea4-9831-4539-9c9f-925b9533ebf8; name=MyProject;
                  url=https://dev.azure.com/myorg/_apis/projects/44b34ea4-9831-4539-9c9f-925b9533ebf8; state=wellFormed; revision=2249; visibility=private;
                  lastUpdateTime=7/19/2024 10:08:11 PM}
size            : 0
remoteUrl       : https://myorg@dev.azure.com/myorg/MyProject/_git/my%20forked%20repo
sshUrl          : git@ssh.dev.azure.com:v3/myorg/MyProject/my%20forked%20repo
webUrl          : https://dev.azure.com/myorg/MyProject/_git/my%20forked%20repo
isFork          : True
_links          : @{self=; project=; web=; ssh=; commits=; refs=; pullRequests=; items=; pushes=; forkSyncOperation=}
isDisabled      : False
isInMaintenance : False
```

Create a forked repository inside your project

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

Name of the repository to create

```yaml
Type: System.String
Parameter Sets: Fork
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

```yaml
Type: System.String
Parameter Sets: Repo
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentProjectId

Project where the repository to fork is located

```yaml
Type: System.String
Parameter Sets: Fork
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentRepositoryId

Id of the repository the fork will be created from

```yaml
Type: System.String
Parameter Sets: Fork
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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

The Project to create the repository in

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/New-AdoRepository.md#new-adorepository](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/New-AdoRepository.md#new-adorepository)
