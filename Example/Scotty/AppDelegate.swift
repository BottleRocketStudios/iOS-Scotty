//
//  AppDelegate.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import UserNotifications
import Scotty
import CoreSpotlight
import MobileCoreServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
		
		configureUserNotificationCenter()
		configureIndexableItems()
		
		if launchOptionsContainsRoute(launchOptions) {
			return handleLaunchOptionsRoute(launchOptions)
		}
		
		// Override point for customization after application launch.
		return true
	}
	
	//MARK: State Restoration
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return Router.default.open(url)
	}
	
	func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
		return Router.default.open(userActivity)
	}
	
	func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
		completionHandler(Router.default.open(shortcutItem))
	}
	
	@available(iOS 10.0, *)
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		Router.default.open(response)
		completionHandler()
	}
	
	@available(iOS 10.0, *)
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler([.badge, .alert, .sound])
	}
}

//MARK: App Configuration
extension AppDelegate {
	
	func handleLaunchOptionsRoute(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		if let url = launchOptions?[.url] as? URL {
			return Router.default.open(url)
		} else if let shortcutItem = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
			return Router.default.open(shortcutItem)
		} else if let activityType = launchOptions?[.userActivityType] as? String {
			let userActivity = NSUserActivity(activityType: activityType)
			return Router.default.open(userActivity)
		}
		
		return false
	}
	
	func launchOptionsContainsRoute(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		if let _ = launchOptions?[.url] as? URL {
			return true
		} else if let _ = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
			return true
		} else if let _ = launchOptions?[.userActivityType] as? String {
			return true
		} else {
			return false
		}
	}
	
	func configureUserNotificationCenter() {
		if #available(iOS 10.0, *) {
			UNUserNotificationCenter.current().delegate = self
		}
	}
}

//MARK: Spotlight Indexing
extension AppDelegate {
    
    func configureIndexableItems() {
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.displayName = "LEFT!"
        attributes.keywords = ["left", "tab", "route", "home"]
        
        let left = CSSearchableItem(uniqueIdentifier: "com.bottlerocketapps.routes.general.leftTab", domainIdentifier: "com.bottlerocketapps.routes.general", attributeSet: attributes)
        
        let attributes2 = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes2.displayName = "MIDDLE!"
        attributes2.keywords = ["middle", "tab", "route"]
        
        let middle = CSSearchableItem(uniqueIdentifier: "com.bottlerocketapps.routes.general.middleTab", domainIdentifier: "com.bottlerocketapps.routes.general", attributeSet: attributes2)
        
        let attributes3 = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes3.displayName = "RIGHT!"
        attributes3.keywords = ["right", "tab", "route"]
        
        let right = CSSearchableItem(uniqueIdentifier: "com.bottlerocketapps.routes.general.rightTab", domainIdentifier: "com.bottlerocketapps.routes.general", attributeSet: attributes3)
        
        let indexableItems = [left, middle, right]
        CSSearchableIndex.default().indexSearchableItems(indexableItems) { (error) in
            if let error = error {
                debugPrint("Error indexing items with CoreSpotlight: \(error.localizedDescription)")
            }
        }
    }
}



