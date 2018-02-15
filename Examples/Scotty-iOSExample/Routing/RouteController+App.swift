//
//  RouteController+App.swift
//  RouteKit
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

class Router {
	
	static var `default`: RouteController<UITabBarController> {
		guard let window = UIApplication.shared.windows.first, let rootVC = window.rootViewController as? UITabBarController else {
            fatalError("The application architecture has changed - our root view controller is no longer a UITabBarController. Developer error.")
        }
        
		return RouteController(rootViewController: rootVC)
	}
}
