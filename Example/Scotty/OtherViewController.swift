//
//  OtherViewController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

class OtherViewController: UIViewController {
    
    @IBAction func goToRight() {
        RouteController<UITabBarController>.default.open(AnyRoute.rightTab)
    }
}
