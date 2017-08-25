//
//  LastViewController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation
import Scotty

class LastViewController: UIViewController {
	
	//MARK: Actions
    @IBAction func goToLeft() {
		Router.default.open(AnyRoute.leftTab)
    }
}
