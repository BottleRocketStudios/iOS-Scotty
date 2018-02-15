import UIKit
import XCTest
@testable import Scotty

class Tests: XCTestCase {
	
	func testSuspendingRouteHandlingInInitializers() {
		let routeController = RouteController(rootViewController: UIViewController())
		XCTAssertTrue(routeController.isPreparedForRouting)
		
		let otherController = RouteController(rootViewController: UIViewController(), ready: false)
		XCTAssertFalse(otherController.isPreparedForRouting)
	}
	
	func testSuspendingRouteHandlingTemporally() {
		let routeController = RouteController(rootViewController: UIViewController(), ready: true)
		XCTAssertTrue(routeController.isPreparedForRouting)
		
		routeController.suspendHandlingRoutes()
		XCTAssertFalse(routeController.isPreparedForRouting)
		
		routeController.resumeHandlingRoutes()
		XCTAssertTrue(routeController.isPreparedForRouting)
		
		routeController.setRouteHandling(enabled: true)
		XCTAssertTrue(routeController.isPreparedForRouting)
		
		routeController.setRouteHandling(enabled: false)
		XCTAssertFalse(routeController.isPreparedForRouting)
	}
	
	func testClearOfStoredRoutes() {
		let routeController = RouteController(rootViewController: UIViewController(), ready: false)
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { _, _ in return true }
		routeController.open(testRoute)
		XCTAssertNotNil(routeController.storedRoute)
		
		routeController.resumeHandlingRoutes(with: .none)
		XCTAssertNotNil(routeController.storedRoute)
		
		routeController.resumeHandlingRoutes(with: .clear)
		XCTAssertNil(routeController.storedRoute)
	}
	
	func testAutomaticExecutionOfStoredRoutes() {
		let exp = expectation(description: "routeExecution")
		let routeController = RouteController(rootViewController: UIViewController(), ready: false)
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { _, _ in
			exp.fulfill()
			return true
		}
		
		routeController.open(testRoute)
		XCTAssertNotNil(routeController.storedRoute)
		
		routeController.resumeHandlingRoutes()
		XCTAssertNil(routeController.storedRoute)
		
		waitForExpectations(timeout: 0.5, handler: nil)
	}
	
	func testAutomaticOpeningOfRouteConvertibles() {
		let routeController = RouteController(rootViewController: UIViewController(), ready: true)
		XCTAssertTrue(routeController.open(SomeRouteConvertible()))
	}
	
	func testHandlingOfRouteConvertibleFailure() {
		let routeController = RouteController(rootViewController: UIViewController(), ready: true)
		XCTAssertFalse(routeController.open(FailingRouteConvertible()))
	}
	
	func testRouteActionableDestination() {
		let exp = expectation(description: "routeExecution")
		let routeController = RouteController(rootViewController: UIViewController())
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { _, _ in
			
			let actionable = ActionableObject()
            actionable.setRouteAction {
                exp.fulfill()
            }
            
            actionable.setPreparedForAction(true)
			
			return true
		}
		
		routeController.open(testRoute)
		
		waitForExpectations(timeout: 0.5, handler: nil)
	}
	
	func testRouteActionExecutesOnce() {
		let exp = expectation(description: "routeExecution")
        
        let actionable = ActionableObject()
        actionable.setRouteAction {
            exp.fulfill()
        }
        
        actionable.setPreparedForAction(true)
        actionable.setPreparedForAction(true)
        
		waitForExpectations(timeout: 0.5, handler: nil)
	}
	
	func testNestedAnyRouteInitializers() {
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { _, _ in return true }
		let nestedRoute = AnyRoute(routable: testRoute)
		
		XCTAssert(testRoute.isSuspendable == nestedRoute.isSuspendable)
		
		let routeA = testRoute.route(fromRootViewController: UIViewController(), options: nil)
		let routeB = nestedRoute.route(fromRootViewController: UIViewController(), options: nil)
		XCTAssert(routeA == routeB)
	}
	
	func testNestedAnyRouteInitializerOverrideSuspendable() {
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { _, _ in return true }
		let nestedRoute = AnyRoute(routable: testRoute, suspendable: false)
		
		XCTAssert(testRoute.isSuspendable != nestedRoute.isSuspendable)
		XCTAssertTrue(testRoute.isSuspendable)
		XCTAssertFalse(nestedRoute.isSuspendable)
	}
	
	func testRouteIdentifierEquality() {
		let a = RouteIdentifier(rawValue: "a")
		let b = RouteIdentifier(rawValue: "b")
		let c = RouteIdentifier(rawValue: "a")
		
		XCTAssert(a == c)
		XCTAssertFalse(a == b)
	}
    
    func testRouteIdentifierPatternMatching() {
        let e = expectation(description: "pattern match")
        let a = RouteIdentifier(rawValue: "a")
        let b = RouteIdentifier(rawValue: "b")
        
        switch a {
        case b: XCTFail("Incorrect match.")
        case a: e.fulfill()
        default: XCTFail("Incorrect match.")
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testRoutablePatternMatching() {
        let e = expectation(description: "pattern match")
        let id = RouteIdentifier(rawValue: "test")
        let r = AnyRoute(id: id) { _, _ in return true }
        
        switch r {
        case id: e.fulfill()
        default: XCTFail("Incorrect match.")
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
	// MARK: Testing Structs
	fileprivate struct SomeRouteConvertible: RouteConvertible {
		var route: AnyRoute<UIViewController>? {
			return AnyRoute(id: RouteIdentifier(rawValue: "test")) { _, _ in
				return true
			}
		}
	}
	
	fileprivate struct FailingRouteConvertible: RouteConvertible {
		var route: AnyRoute<UIViewController>? {
			return nil
		}
	}
	
	fileprivate class ActionableObject: RouteActionable {
        var isPreparedForAction: Bool = false
		var routeAction: RouteAction?
	}
}
