//
//  Route.swift
//  Scotty-iOS
//
//  Created by Will McGinty on 3/19/18.
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

import Foundation

public struct Route<RootViewController: UIViewController> {
    public typealias Options = [AnyHashable: Any]
    public typealias Navigator = (_ rootViewController: RootViewController, _ options: Options?) -> Bool
    
    // MARK: Properties
    private let navigator: Navigator

    /// Determines if this Routable object can be suspended by its executing RouteController. If this property is set to false, this route will always execute immediately.
    let isSuspendable: Bool
    
    /// A unique identifier for this Routable object. Should be unique among all routes an application supports.
    let identifier: RouteIdentifier
    
    // MARK: Initializers
    public init(identifier: RouteIdentifier, isSuspendable: Bool = true, navigator: @escaping Navigator) {
        self.identifier = identifier
        self.isSuspendable = isSuspendable
        self.navigator = navigator
    }
    
    public init(route: Route<RootViewController>, isSuspendable: Bool = true) {
        self.init(identifier: route.identifier, isSuspendable: isSuspendable, navigator: route.navigator)
    }
    
    /// Determines the specifics of the route. This function should make any necessary requirements to the navigation hierarchy to reach the intended destination.
    /// If the intended destination can be reached successfully, this function should return true. Otherwise, return false.
    ///
    /// - Parameters:
    ///   - rootViewController: The view controller at the root of the navigation hierarchy.
    ///   - options: Any routing options that should be taken into account when routing.
    /// - Returns: Return true if the routing is successful, false otherwise.
    func route(fromRootViewController rootViewController: RootViewController, options: Options?) -> Bool {
        return navigator(rootViewController, options)
    }
}

// MARK: Pattern Match {
public extension Route {
    static func ~= (lhs: RouteIdentifier, rhs: Route) -> Bool {
        return lhs == rhs.identifier
    }
}
