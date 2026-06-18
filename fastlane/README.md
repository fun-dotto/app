fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android deploy_firebase_app_distribution

```sh
[bundle exec] fastlane android deploy_firebase_app_distribution
```

Deploy to Firebase App Distribution

### android deploy_google_play

```sh
[bundle exec] fastlane android deploy_google_play
```

Deploy a new version to the Google Play

----


## iOS

### ios match_development

```sh
[bundle exec] fastlane ios match_development
```

Match Development

### ios match_adhoc

```sh
[bundle exec] fastlane ios match_adhoc
```

Match Ad Hoc

### ios match_appstore

```sh
[bundle exec] fastlane ios match_appstore
```

Match App Store

### ios match_development_readonly

```sh
[bundle exec] fastlane ios match_development_readonly
```

Fetch Development

### ios match_adhoc_readonly

```sh
[bundle exec] fastlane ios match_adhoc_readonly
```

Fetch Ad Hoc

### ios match_appstore_readonly

```sh
[bundle exec] fastlane ios match_appstore_readonly
```

Fetch App Store

### ios register_new_devices

```sh
[bundle exec] fastlane ios register_new_devices
```

Register devices

### ios reset_build_number

```sh
[bundle exec] fastlane ios reset_build_number
```

Reset build number

### ios pre_build

```sh
[bundle exec] fastlane ios pre_build
```

Pre-build

### ios build_production

```sh
[bundle exec] fastlane ios build_production
```

Build Production

### ios deploy_ota

```sh
[bundle exec] fastlane ios deploy_ota
```

Build OTA (per flavor)

Deploy OTA (dev, stg, prd)

### ios deploy_to_testflight

```sh
[bundle exec] fastlane ios deploy_to_testflight
```

Deploy to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
