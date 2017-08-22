//
//  NSUserActivity+RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty
import CoreSpotlight

extension NSUserActivity: RouteConvertible {
    public typealias RoutableType = AnyRoute<UITabBarController>
    
    public var route: AnyRoute<UITabBarController>? {
        guard let activityType = userInfo?[CSSearchableItemActivityIdentifier] as? String else { return nil }
		return AnyRoute.route(forIdentifier: activityType)
    }
}
