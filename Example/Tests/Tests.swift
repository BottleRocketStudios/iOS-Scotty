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
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { (vc: UIViewController, options) in return true }
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
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { (vc: UIViewController, options) in
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
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { (vc: UIViewController, options) in
			
			let actionable = ActionableObject()
			let routeAction = RouteAction {
				exp.fulfill()
			}
			actionable.routeAction = routeAction
			actionable.setReadyForRouteAction()
			
			return true
		}
		
		routeController.open(testRoute)
		
		waitForExpectations(timeout: 0.5, handler: nil)
	}
	
	func testRouteActionExecutesOnce() {
		let exp = expectation(description: "routeExecution")
		var routeAction = RouteAction {
			exp.fulfill()
		}
		
		routeAction.isPreparedForAction = true
		routeAction.isPreparedForAction = true
		
		waitForExpectations(timeout: 0.5, handler: nil)
	}
	
	func testNestedAnyRouteInitializers() {
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { (vc: UIViewController, options) in return true }
		let nestedRoute = AnyRoute(routable: testRoute)
		
		XCTAssert(testRoute.isSuspendable == nestedRoute.isSuspendable)
		
		let routeA = testRoute.route(fromRootViewController: UIViewController(), options: nil)
		let routeB = nestedRoute.route(fromRootViewController: UIViewController(), options: nil)
		XCTAssert(routeA == routeB)
	}
	
	func testNestedAnyRouteInitializerOverrideSuspendable() {
		let testRoute = AnyRoute(id: RouteIdentifier(rawValue: "test")) { (vc: UIViewController, options) in return true }
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
	
	//MARK: Testing Structs
	fileprivate struct SomeRouteConvertible: RouteConvertible {
		var route: AnyRoute<UIViewController>? {
			return AnyRoute(id: RouteIdentifier(rawValue: "test")) { vc, options in
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
		
		var routeAction: RouteAction?
		
		func setReadyForRouteAction() {
			routeAction?.isPreparedForAction = true
		}
	}
}
