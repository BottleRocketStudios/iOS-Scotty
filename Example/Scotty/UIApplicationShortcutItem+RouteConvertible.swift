//
//  UIApplicationShortcutItem+RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import RouteKit

extension UIApplicationShortcutItem: RouteConvertible {
    public typealias RoutableType = AnyRoute<UITabBarController>
    
    public var route: AnyRoute<UITabBarController>? {
		return AnyRoute.route(forIdentifier: type)
    }
}
