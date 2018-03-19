//
//  UNNotificationResponse+RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import UserNotifications
import Scotty

@available(iOS 10.0, *)
extension UNNotificationResponse {

    public var route: Route<UITabBarController>? {
		return Route.route(forIdentifier: actionIdentifier)
    }
}
