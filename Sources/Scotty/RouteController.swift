//
//  RouteController.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation

/// The RouteController object handles the execution of routes as entry points into your application.
/// The route controller is generic over its rootViewController (which can be any subclass of UIViewController), meaning that it will only accept routes that begin in the same rootViewController type as it was created with.
open class RouteController<RootViewController: UIViewController>: NSObject {
    
    // MARK: Properties
	fileprivate let rootViewController: RootViewController
    fileprivate(set) var isPreparedForRouting = false
	fileprivate(set) var storedRoute: (() -> Void)?
    
    // MARK: Initializers
    public init(rootViewController: RootViewController, ready: Bool = true) {
        self.rootViewController = rootViewController
        super.init()
        
        setRouteHandling(enabled: ready)
    }
}

// MARK: Route Processing
public extension RouteController {

    /// Attempts to open (and execute) any object that conforms to the RouteConvertible protocol, passing in the providing routing options during execution. If routing reaches its intended destination, returns true. Otherwise returns false.
    ///
    /// - Parameters:
    ///   - routeConvertible: The object to be converted to a Routable and executed.
    ///   - options: Any routing options that should be taken into account when routing.
    /// - Returns: Returns true if routing reaches its intended destination, otherwise returns false.
    @discardableResult
    func open<T: RouteConvertible>(_ routeConvertible: T, options: Routable.Options? = nil) -> Bool where T.RoutableType.RootViewController == RootViewController {
        guard let route = routeConvertible.route else { return false }
        return open(route, options: options)
    }
	
	/// Attempts to open (and execute) any object that conforms to the Routable protocol, passing in the providing routing options during execution. If routing reaches its intended destination, returns true. Otherwise returns false.
	///
	/// - Parameters:
	///   - routable: The object to be executed.
	///   - options: Any routing options that should be taken into account when routing.
	/// - Returns: Returns true if routing reaches its intended destination, otherwise returns false.
    @discardableResult
    func open<T: Routable>(_ routable: T, options: Routable.Options? = nil) -> Bool where T.RootViewController == RootViewController {
        guard isPreparedForRouting || !routable.isSuspendable else { storedRoute = stored(routable: routable, options: options); return false }
        return routable.route(fromRootViewController: rootViewController, options: options)
    }
}

// MARK: Routing Availability
public extension RouteController {
	
	/// The StoredRoutePolicy determines the outcome of any routes the RouteController has stored when it resumes handling routes.
	///
	/// - execute: The stored route will be executed, and then cleared.
	/// - clear: The stored route will be cleared. It will not be executed.
	/// - none: The stored route will not be cleared or executed.
	enum StoredRoutePolicy {
		case execute
		case clear
		case none
		
		fileprivate func executePolicy(with routeController: RouteController<RootViewController>) {
			switch self {
			case .execute:
				routeController.executeStoredRoute()
			case .clear:
				routeController.clearStoredRoute()
			default: return
			}
		}
	}
	
	/// Instructs the controller to resume route handling.
	///
	/// - Parameter storedRoutePolicy: Determines how any stored (as yet unexecuted) routes should be handled at resume time.
	func resumeHandlingRoutes(with storedRoutePolicy: StoredRoutePolicy = .execute) {
        isPreparedForRouting = true
		storedRoutePolicy.executePolicy(with: self)
    }
	
    /// Instructs the controller to suspend route handling. Note that even while route handling is suspended, any routes where isSuspendable = false will still be executed.
    func suspendHandlingRoutes() {
        isPreparedForRouting = false
    }
	
    /// Modify the route controller's ability to handle routes.
    ///
    /// - Parameter enabled: Passing in true will allow the controller to resume handling routes.
    /// False will suspend route handling. Note that even while route handling is suspended, any routes where isSuspendable = false will still be executed.
    func setRouteHandling(enabled: Bool) {
        enabled ? resumeHandlingRoutes() : suspendHandlingRoutes()
	}
}

// MARK: Stored (Delayed) Links
fileprivate extension RouteController {
	
	func executeStoredRoute() {
		storedRoute?()
		clearStoredRoute()
	}
	
	func clearStoredRoute() {
		storedRoute = nil
	}
}

// MARK: Route Storage
fileprivate extension RouteController {
    
    func stored<T: Routable> (routable: T, options: Routable.Options?) -> () -> Void where T.RootViewController == RootViewController {
        return { [weak self] in
            self?.open(routable, options: options)
        }
    }
}
