//
//  OtherViewController.swift
//  Scotty
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty

class OtherViewController: UIViewController {
	
	// MARK: Actions
    @IBAction func goToRight() {
        Router.default.open(.rightTab)
    }
}
