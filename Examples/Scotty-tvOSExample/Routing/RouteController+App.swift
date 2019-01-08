//
//  RouteController+App.swift
//  Scotty-iOS
//
//  Created by Fernando Arocho on 1/8/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty_tvOS

class Router {
    
    static var `default`: RouteController<UITabBarController> {
        guard let window = UIApplication.shared.windows.first, let rootVC = window.rootViewController as? UITabBarController else {
            fatalError("The application architecture has changed - our root view controller is no longer a UITabBarController. Developer error.")
        }
        
        return RouteController(rootViewController: rootVC)
    }
}
