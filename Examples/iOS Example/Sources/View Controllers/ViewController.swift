//
//  ViewController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import UserNotifications
import Scotty

class ViewController: UIViewController, RouteRespondable {

    // MARK: Properties
    var isPreparedForAction: Bool = false
    var routeAction: RouteRespondable.Action?

	// MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		
        // Calling this method with a value of 'true' will cause the routeAction (if present) to execute
        setPreparedForAction(true)
    }
	
	// MARK: Actions
    @IBAction func goToMiddle() {
        Router.default.open(.middleTab)
    }
    
    @IBAction func triggerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in
            
            // Create three actions for a generic notification category
            let leftAction = UNNotificationAction(identifier: "leftTab", title: "Left", options: [.foreground])
            let middleAction = UNNotificationAction(identifier: "middleTab", title: "Middle", options: [.foreground])
            let rightAction = UNNotificationAction(identifier: "rightTab", title: "Right", options: [.foreground])
            
            let category = UNNotificationCategory(identifier: "aNotification", actions: [leftAction, middleAction, rightAction], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            // Create a sample notification in the category we previously created
            let content = UNMutableNotificationContent()
            content.categoryIdentifier = "aNotification"
            content.title = "This is a rich notification!"
            content.body = "Where in the app do you want to go?"
            
            // Request this notification to fire in 5.0 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
            let request = UNNotificationRequest(identifier: "aRequest", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
    }
}
