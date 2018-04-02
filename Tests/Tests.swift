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
		let testRoute = Route(identifier: RouteIdentifier(rawValue: "test")) { _, _ in return true }
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
		let testRoute = Route(identifier: RouteIdentifier(rawValue: "test")) { _, _ in
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
		XCTAssertTrue(routeController.open(SomeRouteConvertible().route))
	}
	
	func testHandlingOfRouteConvertibleFailure() {
		let routeController = RouteController(rootViewController: UIViewController(), ready: true)
		XCTAssertFalse(routeController.open(FailingRouteConvertible().route))
	}
	
	func testRouteActionableDestination() {
		let exp = expectation(description: "routeExecution")
		let routeController = RouteController(rootViewController: UIViewController())
		let testRoute = Route(identifier: RouteIdentifier(rawValue: "test")) { _, _ in
			
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
    
    func testRouteActionExecutesImmediatelyIfReady() {
        let obj = ActionableObject()
        obj.isPreparedForAction = true
        
        let exp = expectation(description: "executesImmediately")
        obj.setRouteAction {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
	
	func testNestedAnyRouteInitializers() {
		let testRoute = Route(identifier: RouteIdentifier(rawValue: "test")) { _, _ in return true }
		let nestedRoute = Route(route: testRoute)
		
		XCTAssert(testRoute.isSuspendable == nestedRoute.isSuspendable)
		
		let routeA = testRoute.route(fromRootViewController: UIViewController(), options: nil)
		let routeB = nestedRoute.route(fromRootViewController: UIViewController(), options: nil)
		XCTAssert(routeA == routeB)
	}
	
	func testNestedAnyRouteInitializerOverrideSuspendable() {
		let testRoute = Route(identifier: RouteIdentifier(rawValue: "test")) { _, _ in return true }
		let nestedRoute = Route(route: testRoute, isSuspendable: false)
		
		XCTAssert(testRoute.isSuspendable != nestedRoute.isSuspendable)
		XCTAssertTrue(testRoute.isSuspendable)
		XCTAssertFalse(nestedRoute.isSuspendable)
	}
	
	func testRouteIdentifierEquality() {
		let idA = RouteIdentifier(rawValue: "a")
		let idB = RouteIdentifier(rawValue: "b")
		let idC = RouteIdentifier(rawValue: "a")
		
		XCTAssert(idA == idC)
		XCTAssertFalse(idA == idB)
	}
    
    func testRouteIdentifierPatternMatching() {
        let exp = expectation(description: "pattern match")
        let idA = RouteIdentifier(rawValue: "a")
        let idB = RouteIdentifier(rawValue: "b")
        
        switch idA {
        case idB: XCTFail("Incorrect match.")
        case idA: exp.fulfill()
        default: XCTFail("Incorrect match.")
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testRoutablePatternMatching() {
        let exp = expectation(description: "pattern match")
        let id = RouteIdentifier(rawValue: "test")
        let route = Route(identifier: id) { _, _ in return true }
        
        switch route {
        case id: exp.fulfill()
        default: XCTFail("Incorrect match.")
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
	// MARK: Testing Structs
	fileprivate struct SomeRouteConvertible {
		var route: Route<UIViewController>? {
			return Route(identifier: RouteIdentifier(rawValue: "test")) { _, _ in
				return true
			}
		}
	}
	
	fileprivate struct FailingRouteConvertible {
		var route: Route<UIViewController>? {
			return nil
		}
	}
	
	fileprivate class ActionableObject: RouteRespondable {
        var isPreparedForAction: Bool = false
		var routeAction: Action?
	}
}
