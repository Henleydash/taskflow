# Changelog

All notable changes to TaskFlow are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.2.0] - 2026-09-09
### Added
- Full internationalization (FR default, EN) via ARB files and `flutter_localizations`.
- Dark mode toggle and language switcher on the Settings screen.
- Statistics panel (total / pending / completed) on Settings.
- Semantic labels across all interactive elements (checkboxes, chips, buttons, badges).
### Changed
- Migrated task list rendering to `const`-friendly `TaskCard` widgets to eliminate unnecessary rebuilds.
### Fixed
- Overdue tasks now correctly exclude completed tasks from the warning indicator.

## [1.1.0] - 2026-08-20
### Added
- Category filter bar on the home screen.
- Task detail screen with edit and delete (with confirmation dialog).
- `flutter_hooks` adoption in the task form for local state without `StatefulWidget` boilerplate.
### Changed
- Replaced ad-hoc state handling with a `StateNotifier`-based `TaskNotifier` and typed `TaskState`.

## [1.0.0] - 2026-08-01
### Added
- Initial release: clean-architecture skeleton (domain / data / presentation).
- Hive-backed local persistence for tasks.
- Core CRUD flow: add, list, complete, delete tasks with priority and category.
- Splash and home screens.
