//
//  ViewController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import UserNotifications
import Scotty

class ViewController: UIViewController, RouteActionable {
    
    var routeAction: RouteAction?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        routeAction?.isPreparedForAction = true
    }
    
    @IBAction func goToMiddle() {
        RouteController<UITabBarController>.default.open(AnyRoute.middleTab)
    }
    
    @IBAction func triggerNotification() {
		if #available(iOS 10.0, *) {
			UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
				let leftAction = UNNotificationAction(identifier: "leftTab", title: "Left", options: [.foreground])
				let middleAction = UNNotificationAction(identifier: "middleTab", title: "Middle", options: [.foreground])
				let rightAction = UNNotificationAction(identifier: "rightTab", title: "Right", options: [.foreground])
				
				let category = UNNotificationCategory(identifier: "aNotification", actions: [leftAction, middleAction, rightAction], intentIdentifiers: [], options: [])
				UNUserNotificationCenter.current().setNotificationCategories([category])
				
				let content = UNMutableNotificationContent()
				content.categoryIdentifier = "aNotification"
				content.title = "This is a rich notification!"
				content.body = "Where in the app do you want to go?"
				
				let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
				
				let request = UNNotificationRequest(identifier: "aRequest", content: content, trigger: trigger)
				UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
			}
		}
    }
}

