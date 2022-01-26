//
//  UNNotificationResponse+RouteConvertible.swift
//  Example
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import UserNotifications
import Scotty

extension UNNotificationResponse {

    public var route: Route<UITabBarController>? {
		return Route.route(forIdentifier: actionIdentifier)
    }
}
