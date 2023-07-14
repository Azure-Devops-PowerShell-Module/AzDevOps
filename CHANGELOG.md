# Changelog

All changes to this module should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [[2.2.0]](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/releases/tag/v2.2.0) - 2023-08-31

This release adds feed, artifact and nuget functions. We should be able to perform all CRUD operations
on feeds. We should be able to get packages and their versions and finally download a specific package
from nuget.

A lot of updates in this release:

1. Feed Management
   1. Get a Feed [issue-37](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/37)
   2. Get Feed View [issue-38](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/38)
   3. Create a Feed [issue-39](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/39)
   4. Update a Feed [issue-41](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/41)
   5. Delete a Feed [issue-40](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/40)
   6. Create a View [issue-42](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/42)
   7. Update a View [issue-44](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/44)
   8. Delete a View [issue-43](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/43)
2. Artifact Details
   1. Get a Package [issue-45](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/45)
   2. Get a Package Version [issue-46](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/46)
3. Artifact Package Types / Nuget
   1. Download a Package [issue-47](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/issues/47)

## [[2.1.0]](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/releases/tag/v2.1.0) - 2023-01-14

This release adds the git endpoint as well as testing for module functions.

What's changed:

1. Git Repositories Functions [ADPM-4](https://pattontech.atlassian.net/browse/ADPM-4)
   1. Get-AdoRepository [ADPM-2](https://pattontech.atlassian.net/browse/ADPM-2)
   2. New-AdoRepository [ADPM-3](https://pattontech.atlassian.net/browse/ADPM-3)
      1. See Github Issue [587](https://github.com/MicrosoftDocs/vsts-rest-api-specs/issues/587)
   3. Remove-AdoRepository [ADPM-5](https://pattontech.atlassian.net/browse/ADPM-5)
2. Update API Version across functions [ADPM-7](https://pattontech.atlassian.net/browse/ADPM-7)

---

## [[2.0.0]](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/releases/tag/v2.0.0) - 2023-01-14

This release is a complete overhaul of the module. Functions have been seperated into individual files and stored in
folders, and the psakefile will handle building and publishing the module.

### Breaking Change

Modules prefixes have been changed from AzDevOps to Ado

What's changed:

1. Module functions are stored in folders and scripts
2. PsakeFile updated to work with module and nested modules
3. Invoke-AdoEndpoint function created
   1. Define all possible APIVersions
   2. Replace existing Invoke-RestMethod across all functions
4. Added new functions for Build
   1. Get-AdoBuild
   2. Get-AdoBuildLog
   3. Remove-AdoBuild
   4. Start-AdoBuild
   5. Get-BuildDefinition
   6. Get-BuildFolder
   7. New-BuildFolder
   8. Remove-BuildFolder
5. API versions have been updated
6. Updated documentaiton

---

## Unreleased

- oAuth2 Authentication Method
- Pester Tests
- Build module

## [1.1.0] - 2020-04-15

### Added

- Created build repository
- Incremented module version to 1.1.0

## [1.0.2] - 2020-04-14

### Added

- Migrated original nested modules into core module
- Fixed Update-AzDevOpsProject that had been removed
- Added About_AzDevOps help

### Changed

- psake to skip processing docs and en-us folders

### Removed

- NestedModules and their repositories

## [1.0.1] - 2020-04-13

### Added

- About Help to all modules
- External Help file location moved for all modules

### Changed

- all modules updated with ExternalHelp directive
- all modules definition updated minor version

### Removed

- Nested external help in /docs

## [1.0.0] - 2020-04-11

### Added

- Team Module
- Projects Module
- Processes Module
- Operations Module
- Authentication Module
- README
