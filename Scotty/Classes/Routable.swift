//
//  Routable.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation

public protocol Routable {
	typealias Options = [AnyHashable: Any]
	associatedtype RootViewController: UIViewController = UIViewController
	
	/// Determines if this Routable object can be suspended by its executing RouteController. If this property is set to false, this route will always execute immediately.
	var isSuspendable: Bool { get }
	
	/// A unique identifier for this Routable object. Should be unique among all routes an application supports.
	var identifier: RouteIdentifier { get }
	
    /// Determines the specifics of the route. This function should make any necessary requirements to the navigation hierarchy to reach the intended destination. If the intended destination can be reached successfully, this function should return true. Otherwise, return false.
    ///
    /// - Parameters:
    ///   - rootViewController: The view controller at the root of the navigation hierarchy.
    ///   - options: Any routing options that should be taken into account when routing.
    /// - Returns: Return true if the routing is successful, false otherwise.
    func route(fromRootViewController rootViewController: RootViewController, options: Options?) -> Bool
}

//MARK: Pattern Match
public extension Routable {
    static func ~=(lhs: RouteIdentifier, rhs: Self) -> Bool {
        return lhs == rhs.identifier
    }
}

/// A type erased struct that can be used to represent any Routable object tied to a given type of root view controller.
public struct AnyRoute<RootViewController: UIViewController>: Routable {
	public typealias Router = (_ rootViewController: RootViewController, _ options: Routable.Options?) -> Bool
	
	/// A closure stored with the object which is used to conform to the Routable protocol. This closure will be executed to run the route.
	private let router: Router
	
	/// A unique identifier for this Routable object. Should be unique among all routes an application supports.
	public var identifier: RouteIdentifier
	
	/// Determines if this Routable object can be suspended by its executing RouteController. If this property is set to false, this route will always execute immediately.
	public var isSuspendable: Bool
	
	//MARK: Initializers
	public init(id: RouteIdentifier, suspendable: Bool = true, routeBlock: @escaping Router) {
		identifier = id
		isSuspendable = suspendable
		router = routeBlock
	}

	public init<T: Routable>(routable: T) where T.RootViewController == RootViewController {
		self.init(id: routable.identifier, suspendable: routable.isSuspendable, routeBlock: routable.route)
	}
	
	public init<T: Routable>(routable: T, suspendable: Bool = true) where T.RootViewController == RootViewController {
		self.init(id: routable.identifier, suspendable: suspendable, routeBlock: routable.route)
	}
	
	/// Determines the specifics of the route. This function should make any necessary requirements to the navigation hierarchy to reach the intended destination. If the intended destination can be reached successfully, this function should return true. Otherwise, return false.
	///
	/// - Parameters:
	///   - rootViewController: The view controller at the root of the navigation hierarchy.
	///   - options: Any routing options that should be taken into account when routing.
	/// - Returns: Return true if the routing is successful, false otherwise.
	public func route(fromRootViewController rootViewController: RootViewController, options: Routable.Options?) -> Bool {
		return router(rootViewController, options)
	}
}
