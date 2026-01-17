# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.6.1] - 2026-01-18

### Added
- HEMTT lints configuration file (.hemtt/lints.toml) for code quality checks
- Combat Zone system moved to its own dedicated addon (addons/combazone/)
- Toggle option for briefing time system

### Changed
- Updated version to 1.6.1
- Improved required addons configuration
- Updated header files across multiple addons
- Optimized `findDisplay` to only execute once
- Updated include files for better compatibility
- Renamed `XEH_PREP.hpp` to `XEH_prep.hpp` for consistency

### Fixed
- Fixed local variable not being private
- Fixed undefined variable issues
- Fixed expected Array[(String), (Any)] type error
- Fixed unoptimized `count` array comparison
- Fixed external class RscXSliderH never being used
- Various code quality improvements based on linter feedback

### Changed Files
- `.gitignore` - Updated ignore patterns
- `.hemtt/project.toml` - Updated project configuration
- `addons/main/script_version.hpp` - Version bump to 1.6.1
- `addons/main/script_macros.hpp` - Macro updates
- Multiple addon files updated for code quality and consistency

### Refactoring
- Removed unused `pohja.sqf` template files from multiple addons
- Combat Zone functionality moved from utilities addon to dedicated combazone addon
- Code cleanup and header standardization across all addons

## [1.6.0] - 2025-06-18

### Added
- Server info addon for displaying server information to clients

**Full Changelog**: https://github.com/tuntematonjr/Tun-Utilities/compare/v1.6.0...v1.6.1
