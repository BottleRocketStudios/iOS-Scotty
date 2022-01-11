#
# Be sure to run `pod lib lint Scotty.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Scotty'
  s.version          = '2.1.1'
  s.summary          = 'A framework designed to make app routing simpler and safer.'

  s.description      = <<-DESC
Scotty provides a simple abstraction around the various entry points to an iOS application. URLs, UIApplicationShortcutItems, NSUserActivities, UNNotificationResponses, and even custom types can be converted into a Route. These routes represent the various destinations your app can deep link too, allowing you to have a single code path through which all application links are executed.
                       DESC

  s.homepage         = 'https://github.com/BottleRocketStudios/iOS-Scotty'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Bottle Rocket Studios' => 'will.mcginty@bottlerocketstudios.com' }
  s.source           = { :git => 'https://github.com/bottlerocketstudios/iOS-Scotty.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.source_files = 'Sources/Scotty/**/*'
  s.frameworks = 'Foundation', 'UIKit'

end
