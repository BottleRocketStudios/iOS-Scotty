//
//  LastViewController.swift
//  Example
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty

class LastViewController: UIViewController {
	
	// MARK: Actions
    @IBAction func goToLeft() {
		Router.default.open(.leftTab)
    }
}
