# Changelog

All changes to this module should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [[2.0.0]](https://github.com/Azure-Devops-PowerShell-Module/AzDevOps/releases/tag/v2.0.0) - 2023-01-11

This release is a complete overhaul of the module. Functions have been seperated into individual files and stored in folders, and the psakefile will handle building and publishing the module.

What's changed:

1. Module functions are stored in folders and scripts
2. PsakeFile updated to work with module and nested modules
3. Invoke-AdoRestMethod function created
   1. Define all possible APIVersions
   2. Replace existing Invoke-RestMethod across all functions
4. API versions have been updated
5. Create Tests

--

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
