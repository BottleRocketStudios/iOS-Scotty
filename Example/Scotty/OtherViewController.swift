//
//  OtherViewController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

class OtherViewController: UIViewController {
	
	//MARK: Actions
    @IBAction func goToRight() {
        Router.default.open(AnyRoute.rightTab)
    }
}
