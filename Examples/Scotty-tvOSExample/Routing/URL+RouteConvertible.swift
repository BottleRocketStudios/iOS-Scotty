//
//  URL+RouteConvertible.swift
//  Scotty-iOS
//
//  Created by Fernando Arocho on 1/8/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty_tvOS

extension URL {
    
    public var route: Route<UITabBarController>? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        return Route.route(forIdentifier: components.path)
    }
}

