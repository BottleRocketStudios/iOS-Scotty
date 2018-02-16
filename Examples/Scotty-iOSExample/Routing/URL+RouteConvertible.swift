//
//  URL+RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

extension URL: RouteConvertible {
    public typealias RoutableType = AnyRoute<UITabBarController>
    
    public var route: AnyRoute<UITabBarController>? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
		return AnyRoute.route(forIdentifier: components.path)
    }
}
