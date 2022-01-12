//
//  URL+RouteConvertible.swift
//  Scotty
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty

extension URL {

    public var route: Route<UITabBarController>? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
		return Route.route(forIdentifier: components.path)
    }
}
