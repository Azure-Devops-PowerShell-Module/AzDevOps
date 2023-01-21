# Changelog

All changes to this module should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
