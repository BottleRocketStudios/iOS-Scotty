//
//  RouteActionable.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation

/// The RouteActionable protocol is adopted by an object that can execute its routeAction at some point during its lifecycle.
public protocol RouteActionable: class {
    
    /// Represents an action to be performed by the conforming object when it deems itself ready to do so.
    typealias RouteAction = () -> Void
    
    /// Controls when any route actions associated with this object are executed.
    var isPreparedForAction: Bool { get set }
    
    /// An optional closure to be executed when the object deems itself ready to do so.
    var routeAction: RouteAction? { get set }
    
    /// Instructs the object it is the 'prepared' state for handling route actions.
    ///
    /// - Parameter prepared: The prepared state for this object. When this value is set to true, any pending actions will be executed.
    func setPreparedForAction(_ prepared: Bool)
    
    /// Instructs the object to perform this action when it deems itself ready to do so.
    ///
    /// - Parameter action: The action that will be executed when prepared.
    func setRouteAction(_ action: @escaping RouteAction)
}

public extension RouteActionable {
    
    func setPreparedForAction(_ prepared: Bool) {
        isPreparedForAction = prepared
        
        //If the object is now prepared for action, execute any pending action
        if prepared, let action = routeAction {
            routeAction = nil
            action()
        }
    }

    func setRouteAction(_ action: @escaping RouteAction) {
        
        //If the object is already prepared, immediately execute and do not store the action.
        guard !isPreparedForAction else { return action() }
        
        //If the object is not prepared, store the action for later
        routeAction = action
    }
}
