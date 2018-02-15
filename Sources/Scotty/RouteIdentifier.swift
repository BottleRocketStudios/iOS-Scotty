//
//  Routable.swift
//  Routes
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import Foundation

/// An object that represents an individual Routable. These identifiers should be unique within your app.
public struct RouteIdentifier: RawRepresentable {
	
	public var rawValue: String
	public init(rawValue: String) {
		self.rawValue = rawValue
	}
}

// MARK: Equatable
extension RouteIdentifier: Equatable {
	public static func == (lhs: RouteIdentifier, rhs: RouteIdentifier) -> Bool {
		return lhs.rawValue == rhs.rawValue
	}
}

// MARK: Pattern Match
extension RouteIdentifier {
    static func ~= (lhs: RouteIdentifier, rhs: RouteIdentifier) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
