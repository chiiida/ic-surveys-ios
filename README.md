# Survey iOS Internal Certification

A survey conducting application build with Swift
## Prerequisites
- Xcode
- CocoaPods
- Xcode Command Line Tools
- Fastlane

## Installation
Clone the project
```
$ git clone https://github.com/llleyelll/ic-surveys-ios.git
```
Navigate to the project directory
```
$ cd ic-surveys-ios
```
Install the latest Pods
```
$ pod install
```

## Run Tests
To run using Fastlane, build the project for testing by using this command:
```
$ bundle exec fastlane build_for_testing
```

Run SwiftLint
```
$ bundle exec fastlane linter
```
Run Unit tests
```
$ bundle exec fastlane unit_test
```
Run UI tests
```
$ bundle exec fastlane ui_test
```
If everything works out smoothly, you should see an output like this: 
```
+------+------------------+-------------+
|           fastlane summary            |
+------+------------------+-------------+
| Step | Action           | Time (in s) |
+------+------------------+-------------+
| 1    | default_platform | 0           |
| 2    | scan             | 141         |
+------+------------------+-------------+

fastlane.tools finished successfully 🎉
```

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
