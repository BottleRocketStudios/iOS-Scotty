//
//  RouteActionable.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation

/// The RouteActionable protocol is adopted by an object that can execute its routeAction at some point during its lifecycle.
public protocol RouteActionable: class {
	
    /// The stored action on the object. This object will execute its action when isPreparedForAction = true.
    var routeAction: RouteAction? { get set }
}

/// The RouteAction object represents a closure that is set to be executed when its owner deems it ready. The action itself will execute once (and only once) on the main thread when ready.
public struct RouteAction {
    
    //MARK: Properties
	public let action: () -> Void
	
    /// This property determines if the RouteAction is prepared to execute. Setting this property to 'true' will trigger the contained action if it has not already executed.
    public var isPreparedForAction: Bool {
        didSet { executeIfNecessary() }
    }
	    
    //MARK: Initializers
	
    /// Initializers a new route action with the provided closure.
    ///
    /// - Parameter action: The closure to be executed when the RouteAction is prepared.
    public init(action: @escaping () -> Void) {
        self.isPreparedForAction = false
        self.action = action
    }
	
    //MARK: Interface
	private var hasExecuted: Bool = false
    private mutating func executeIfNecessary() {
        if isPreparedForAction && !hasExecuted {
			hasExecuted = true
			DispatchQueue.main.async(execute: action)
        }
    }
}
