//
//  Routable+App.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty

// MARK: Specialized Routes
extension RouteIdentifier {
	static let leftTabRoute = RouteIdentifier(rawValue: "leftTab")
	static let middleTabRoute = RouteIdentifier(rawValue: "middleTab")
	static let rightTabRoute = RouteIdentifier(rawValue: "rightTab")
}

// MARK: Define Specialized Routes
extension AnyRoute where RootViewController == UITabBarController {
	    
    static var leftTab: AnyRoute {
		return AnyRoute(id: .leftTabRoute) { rootViewController, _ -> Bool in
            rootViewController.selectedIndex = 0
            
            if let routeActionableController = rootViewController.selectedViewController as? RouteActionable {
                routeActionableController.setRouteAction {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        print("LeftTab successfully reached!")
                    }
                }
            }
            
            return true
        }
    }
    
    static var middleTab: AnyRoute {
        return AnyRoute(id: .middleTabRoute) { rootViewController, _ -> Bool in
            rootViewController.selectedIndex = 1
            return true
        }
    }
    
    static var rightTab: AnyRoute {
        return AnyRoute(id: .rightTabRoute) { rootViewController, _ -> Bool in
            rootViewController.selectedIndex = 2
            return true
        }
    }
}

// MARK: Helper
extension AnyRoute where RootViewController == UITabBarController {
	
	static func route(forIdentifier identifier: String) -> AnyRoute? {
		if identifier.contains(RouteIdentifier.leftTabRoute.rawValue) {
			return leftTab
		} else if identifier.contains(RouteIdentifier.middleTabRoute.rawValue) {
			return middleTab
		} else if identifier.contains(RouteIdentifier.rightTabRoute.rawValue) {
			return rightTab
		}
		
		return nil
	}
}
