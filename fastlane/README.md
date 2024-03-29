fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios linter
```
fastlane ios linter
```
Run SwiftLint
### ios build_for_testing
```
fastlane ios build_for_testing
```
Build for testing
### ios unit_test
```
fastlane ios unit_test
```
Run unit test
### ios ui_test
```
fastlane ios ui_test
```
Run UI test
### ios upload_to_firebase
```
fastlane ios upload_to_firebase
```
Upload to firebase app distribution

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
