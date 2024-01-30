# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2024-01-30

### Added

- Support for branch protections as default setting


## [0.2.0] - 2023-10-06

### Added

- Allow to set following flags on repositories:
  - `has_discussions`
  - `has_issues`
  - `has_projects`
  - `has_wiki`
  - `vulnerability_alerts`
- `template` attribute on repository


## [0.1.0] - 2023-10-05

### Added

- Organization settings, users, teams
- Initial simple repositories management
- Outputs:
  - List of organization users
  - List of organization users missing configuration
  - List of organization teams
- Added section in _README.md_ on how to import existing teams

### Changed

- Aligned repository creation settings with GitHub defaults

### Fixed

- Documentation errors (incl. _Input_ items)


[unreleased]: https://github.com/avaloqcloud/terraform-github-organization/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/avaloqcloud/terraform-github-organization/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/avaloqcloud/terraform-github-organization/compare/v0.0.0...v0.1.0
[0.0.0]: https://github.com/avaloqcloud/terraform-github-organization/releases/tag/v0.0.0
