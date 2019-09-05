## Master

##### Enhancements

* Added Carthage support.
[Ryan Gant](https://github.com/ganttastic)
[#29](https://github.com/BottleRocketStudios/iOS-Scotty/pull/29)

* Remove restriction that Route.Root must be a UIViewController.
[Will McGinty](https://github.com/wmcginty)
[#30](https://github.com/BottleRocketStudios/iOS-Scotty/pull/30)

##### Bug Fixes

* None.


## 2.1.0 (2019-04-30)

##### Enhancements

* Migrate to Swift 5.0.
[Earl Gaspard](https://github.com/earlgaspard)
[#25](https://github.com/BottleRocketStudios/iOS-Scotty/pull/25)

##### Bug Fixes

* None.


## 2.0.1 (2018-09-21)

##### Enhancements

* Updated Travis-CI image to Xcode 9.4.
  [Tyler Milner](https://github.com/tylermilner)
  [#18](https://github.com/BottleRocketStudios/iOS-Scotty/pull/18)

* Updated project for Xcode 10.
  [Tyler Milner](https://github.com/tylermilner)
  [#20](https://github.com/BottleRocketStudios/iOS-Scotty/pull/20)

##### Bug Fixes

* None.


## 2.0.0 (2018-07-18)

##### Enhancements

* Update the Readme to remove a few instances of AnyRoute.
  [Will McGinty](https://github.com/wmcginty)
  [#11](https://github.com/BottleRocketStudios/iOS-Scotty/pull/11)
  [#12](https://github.com/BottleRocketStudios/iOS-Scotty/issues/12)
  [#13](https://github.com/BottleRocketStudios/iOS-Scotty/pull/13)

* Enable code coverage for the "Scotty-iOS" scheme.
  [Tyler Milner](https://github.com/tylermilner)
  [#14](https://github.com/BottleRocketStudios/iOS-Scotty/pull/14)

* Access control tweaks, remove `Options` typealias.
  [Will McGinty](https://github.com/wmcginty)
  [#15](https://github.com/BottleRocketStudios/iOS-Scotty/pull/15)

##### Bug Fixes

* None.


## 1.1.0 (2018-05-08)

##### Enhancements

* Codecov and Codebeat integration.
  [Amanda Chappell](https://github.com/achappell)
  [#1](https://github.com/BottleRocketStudios/iOS-Scotty/issues/1)
  [#2](https://github.com/BottleRocketStudios/iOS-Scotty/pull/2)

* Rework project structure.
  [Will McGinty](https://github.com/wmcginty)
  [#3](https://github.com/BottleRocketStudios/iOS-Scotty/pull/3)

* Simplify the public interface.
  [Will McGinty](https://github.com/wmcginty)
  [#6](https://github.com/BottleRocketStudios/iOS-Scotty/pull/6)
  [#7](https://github.com/BottleRocketStudios/iOS-Scotty/issues/7)

* Update CLA URL.
  [Will McGinty](https://github.com/wmcginty)
  [#8](https://github.com/BottleRocketStudios/iOS-Scotty/issues/8)
  [#9](https://github.com/BottleRocketStudios/iOS-Scotty/pull/9)

##### Bug Fixes

* None.


## 1.0.0 (2018-01-05)

##### Enhancements

* Add pattern matching for `Routable` and `RouteIdentifier` types
* Ensure code coverage generation in example project

##### Bug Fixes

* None.


## 0.2.0 (2017-12-12)

##### Enhancements

* Add controllers and protocols to make it simple to handle app routing from many possible input sources. Here's how it works:

```swift
let controller = routeController = RouteController(rootViewController: rootVC)
controller.open(myRoute)
```

##### Bug Fixes

* None.


## 0.1.0 (2017-10-27)

##### Initial Release

This is our initial release of Scotty. Enjoy!
