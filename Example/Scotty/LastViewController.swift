//
//  LastViewController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import RouteKit

class LastViewController: UIViewController {
    
    @IBAction func goToLeft() {
		RouteController<UITabBarController>.default.open(AnyRoute.leftTab)
    }
}
