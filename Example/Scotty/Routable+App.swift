//
//  Routable+App.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import RouteKit

//MARK: Specialized Routes
extension RouteIdentifier {
	static let leftTab = RouteIdentifier(rawValue: "leftTab")
	static let middleTab = RouteIdentifier(rawValue: "middleTab")
	static let rightTab = RouteIdentifier(rawValue: "rightTab")
}

extension AnyRoute where RootViewController == UITabBarController {
	    
    static var leftTab: AnyRoute {
		return AnyRoute(id: .leftTab) { rootViewController, options -> Bool in
            rootViewController.selectedIndex = 0
            
            if let routeActionableController = rootViewController.selectedViewController as? RouteActionable {
                routeActionableController.routeAction = RouteAction {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print("LeftTab successfully reached!")
                    }
                }
            }
            
            return true
        }
    }
    
    static var middleTab: AnyRoute {
        return AnyRoute(id: .middleTab) { rootViewController, options -> Bool in
            rootViewController.selectedIndex = 1
            return true
        }
    }
    
    static var rightTab: AnyRoute {
        return AnyRoute(id: .rightTab) { rootViewController, options -> Bool in
            rootViewController.selectedIndex = 2
            return true
        }
    }
}

extension AnyRoute where RootViewController == UITabBarController {
	
	static func route(forIdentifier identifier: String) -> AnyRoute? {
		
		if identifier.contains(RouteIdentifier.leftTab.rawValue) {
			return leftTab
		} else if identifier.contains(RouteIdentifier.middleTab.rawValue) {
			return middleTab
		} else if identifier.contains(RouteIdentifier.rightTab.rawValue) {
			return rightTab
		}
		
		return nil
	}
}
