## [2.0.0] - 2022-07-05

### Fixed
* Added [fetchMaximumInterval] parameter to set maximum cached interval
* Fixed [remote_config] internal remote config fetch error on fetchAndActivate()

### Changed
* Update firebase_remote_config dependency to use version ^0.10.0+1
* Rename fire_flag to flag_feature

## [1.1.1] - 2021-02-25

### Fixed
* Remove initial return as it causing the listener received the response twice. Let user handle feature flag initial value initialization

## [1.1.0] - 2020-12-02

### Changed
* Update firebase_remote_config dependency to use version ^0.6.0

### Fixed
* Handle to return false when the config parameter is not available on Firebase Console


## [1.0.3] - 2020-12-02

### Fixed
* Fix Readme


## [1.0.2] - 2020-11-30

### Fixed
* Fix homepage URL


## [1.0.1] - 2020-11-30

### Fixed
* Fix sample app for better documentation


## [1.0.0] - 2020-11-30

* Initial release
