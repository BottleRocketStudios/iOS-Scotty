//
//  ViewController.swift
//  Scotty-tvOSExample
//
//  Created by Fernando Arocho on 1/8/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import UserNotifications
import Scotty_tvOS

class LeftViewController: UIViewController, RouteRespondable {
    
    // MARK: Properties
    var isPreparedForAction: Bool = false
    var routeAction: RouteRespondable.Action?
    
    // MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Calling this method with a value of 'true' will cause the routeAction (if present) to execute
        setPreparedForAction(true)
    }
    
    @IBAction func sendToMiddle(_ sender: UIButton) {
        Router.default.open(.middleTab)
    }
}
