//
//  URL+RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

extension URL {

    public var route: Route<UITabBarController>? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
		return Route.route(forIdentifier: components.path)
    }
}
