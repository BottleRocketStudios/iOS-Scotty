//
//  RightViewController.swift
//  Scotty-iOS
//
//  Created by Fernando Arocho on 1/8/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Scotty_tvOS

class RightViewController: UIViewController {

    // MARK: Actions
    @IBAction func goToLeft() {
        Router.default.open(.leftTab)
    }

}
