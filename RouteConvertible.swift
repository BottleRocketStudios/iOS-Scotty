//
//  RouteConvertible.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation

/// The RouteConvertible protocol is adopted by an object that can be converted into a Routable object without any additional input.
public protocol RouteConvertible {
	
    /// The concrete type to which each RouteConvertible type will be converted. This type must conform to the Routable protocol.
    associatedtype RoutableType: Routable
	
    /// Returns an optional object of RoutableType which represents the attempt of Self to convert itself into a route.
    var route: RoutableType? { get }
}
