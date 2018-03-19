//
//  UIApplicationShortcutItem+RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

extension UIApplicationShortcutItem {

    public var route: Route<UITabBarController>? {
		return Route.route(forIdentifier: type)
    }
}
