---
external help file: AzDevOps-help.xml
Module Name: AzDevOps
online version: https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Remove-AdoRepository.md#remove-adorepository
schema: 2.0.0
---

# Remove-AdoRepository

## SYNOPSIS

Delete a git repository

## SYNTAX

### Project

```powershell
Remove-AdoRepository -Project <Object> -Repository <Object> [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ProjectId

```powershell
Remove-AdoRepository -ProjectId <Guid> -RepositoryId <String> [-ApiVersion <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Delete a git repository

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-AdoRepository -Project $Project -Repository $r -Verbose
VERBOSE: RemoveRepository: Begin Processing
VERBOSE: ProjectId: 44b34ea4-9831-4539-9c9f-925b9533ebf8
VERBOSE: RepositoryId: 7d8deb7b-863a-4ef3-bb75-83b4e6ae369a
VERBOSE: ApiVersion: 7.2-preview.1
VERBOSE: Uri: https://dev.azure.com/myorg/44b34ea4-9831-4539-9c9f-925b9533ebf8/_apis/git/repositories/7d8deb7b-863a-4ef3-bb75-83b4e6ae369a?api-version=7.2-preview.1
VERBOSE: InvokeEndpoint : Begin Processing
VERBOSE:  Uri             : https://dev.azure.com/myorg/44b34ea4-9831-4539-9c9f-925b9533ebf8/_apis/git/repositories/7d8deb7b-863a-4ef3-bb75-83b4e6ae369a?api-version=7.2-preview.1
VERBOSE:  Method          : DELETE
VERBOSE:  Headers         : System.Collections.Hashtable
VERBOSE: Requested HTTP/1.1 DELETE with 0-byte payload
VERBOSE: Received HTTP/1.1 response of content type  of unknown size
VERBOSE: Content encoding: utf-8
```

Delete repository

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

Project where the repository is located

```yaml
Type: System.Object
Parameter Sets: Project
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProjectId

Project where the repository is located

```yaml
Type: System.Guid
Parameter Sets: ProjectId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Repository

The repository to remove

```yaml
Type: System.Object
Parameter Sets: Project
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RepositoryId

The repository to remove

```yaml
Type: System.String
Parameter Sets: ProjectId
Aliases:

Required: True
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

[https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Remove-AdoRepository.md#remove-adorepository](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/blob/master/docs/Remove-AdoRepository.md#remove-adorepository)
