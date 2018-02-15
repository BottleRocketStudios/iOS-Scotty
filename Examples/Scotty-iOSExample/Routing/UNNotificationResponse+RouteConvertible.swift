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
extension UNNotificationResponse: RouteConvertible {
    public typealias RoutableType = AnyRoute<UITabBarController>
    
    public var route: AnyRoute<UITabBarController>? {
		return AnyRoute.route(forIdentifier: actionIdentifier)
    }
}
