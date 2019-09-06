Scotty
============
[![CI Status](http://img.shields.io/travis/BottleRocketStudios/iOS-Scotty.svg?style=flat)](https://travis-ci.org/BottleRocketStudios/iOS-Scotty)
[![Version](https://img.shields.io/cocoapods/v/Scotty.svg?style=flat)](http://cocoapods.org/pods/Scotty)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Scotty.svg?style=flat)](http://cocoapods.org/pods/Scotty)
[![Platform](https://img.shields.io/cocoapods/p/Scotty.svg?style=flat)](http://cocoapods.org/pods/Scotty)
[![codecov](https://codecov.io/gh/BottleRocketStudios/iOS-Scotty/branch/master/graph/badge.svg)](https://codecov.io/gh/BottleRocketStudios/iOS-Scotty)
[![codebeat badge](https://codebeat.co/badges/e273e4d9-8bc0-4534-90ad-3d8a49e885de)](https://codebeat.co/projects/github-com-bottlerocketstudios-ios-scotty-master)

### Purpose
This library provides a simple abstraction around the various entry points to an iOS application. URLs, application shortcut items, user activities, notification responses, and even custom types can be converted into a Route. These routes represent the various destinations your app can deep link too, allowing you to have a single code path through which all application links are executed.

### Key Concepts
* Route - An abstract representation of the code required to move your application from its root state to a specific final destination.
* RouteController - An object that is created with a root view controller, and handles the execution of Routes.
* RouteAction - An action that can be taken by the destination of a Route when travel has completed.

### Usage
An instance of the RouteController should be created and retained somewhere accessible by your Application Delegate so that the relevant callbacks can be forwarded on to it. Although the RouteController can be wrapped and treated as a singleton, it does not have to be.

``` swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    var routeController: RouteController<UITabBarController>?
    //In this implementation, our root view controller is a UITabBarController

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        if let window = window, let rootVC = window.rootViewController as? UITabBarController {
            routeController = RouteController(root: rootVC)
        }

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return routeController?.open(url.route) ?? false
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return routeController?.open(userActivity) ?? false
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(routeController?.open(shortcutItem) ?? false)
    }
}
```

In order to make `URL`/`NSUserActivity`/`UIApplicationShortcutItem` compatible with the `RouteController`, they will need to be extended to vend `Route` objects. A simple implementation might look like this:

``` swift
extension URL {

    public var route: Route<UITabBarController>? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        return Route.route(forIdentifier: components.path)
    }
}
```

When dealing with URLs, in addition to vending `Route` objects, you will also need to configure your app with its own URL scheme. More information on this process is available from [Apple](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Inter-AppCommunication/Inter-AppCommunication.html#//apple_ref/doc/uid/TP40007072-CH6-SW1).

### Creating Routes
Creating a new route is as simple as creating a new `Route` instance.

``` swift
extension Route where Root == UITabBarController {
    static var leftTab: Route {
		return Route(identifier: .leftTabRoute) { root, options -> Bool in
            root = 0

            if let routeRespondableController = root.selectedViewController as? RouteRespondable {
                routeRespondableController.setRouteAction {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print("LeftTab successfully reached!")
                    }
                }
            }

            return true
        }
    }
}
```

The above example creates a static instance of the `Route` struct designed to travel to the leftmost tab of the sample application. The identifier is used to differentiate this route from others when converting between types that vend routes (such as `URL`).

The trailing closure is the mechanism of routing. Given the instance of your root view controller, as well as any options provided with the routing request, this closure should execute the required changes to the view controller hierarchy to reach the destination. If the destination can successfully be reached, this closure should return true. Otherwise, it should return false.

### Route Actions
Route Actions are closures that can be executed at particular route destinations. If the route conforms to the RouteRespondable protocol, it will have a public routeAction property which can be set inside the route. When this destination is reached, it will indicate to the routeAction an appropriate time at which to execute.

### Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Requirements

* iOS 9.0+
* Swift 5.0

### Installation 

#### CocoaPods

[CocoaPods]: http://cocoapods.org

Add the following to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html):

```ruby
pod 'Scotty'
```

You will also need to make sure you're opting into using frameworks:

```ruby
use_frameworks!
```

Then run `pod install` with CocoaPods 0.36 or newer.

#### Carthage

Add the following to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
github "BottleRocketStudios/iOS-Scotty"
```

Run `carthage update` and follow the steps as described in Carthage's [README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

### Contributing

See the [CONTRIBUTING] document. Thank you, [contributors]!

[CONTRIBUTING]: CONTRIBUTING.md
[contributors]: https://github.com/BottleRocketStudios/iOS-Scotty/graphs/contributors
