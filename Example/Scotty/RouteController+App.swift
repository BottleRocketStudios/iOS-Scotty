//
//  RouteController+App.swift
//  RouteKit
//
//  Created by Will McGinty on 7/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Scotty

extension RouteController where RootViewController == UITabBarController {
	
	static var `default`: RouteController<UITabBarController> {
		guard let window = UIApplication.shared.keyWindow, let rootVC = window.rootViewController as? UITabBarController else { fatalError("The application architecture has changed - our root view controller is no longer a UITabBarController.") }
		return RouteController(rootViewController: rootVC)
	}
}
