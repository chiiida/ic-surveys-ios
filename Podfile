platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'Sourcery'
  pod 'OHHTTPStubs/Swift'
end

target 'SurveyApp' do
  plugin 'cocoapods-keys', {
    :project => "SurveyApp",
    :keys => [
      "ClientId",
      "ClientSecret"
    ]}

  pod 'NimbleExtension', :git => 'https://github.com/nimblehq/NimbleExtension', :branch => 'master'

  pod 'SnapKit'
  pod 'R.swift'
  pod 'SwiftLint'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'AlamofireNetworkActivityLogger', '~> 3.4'
  pod 'KeychainAccess'

  target 'SurveyAppTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'SurveyAppUITests' do
    testing_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
