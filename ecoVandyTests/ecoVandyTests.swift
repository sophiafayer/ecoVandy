//
//  ecoVandyTests.swift
//  ecoVandyTests
//
//  Created by Sophia Fayer on 2/14/24.
//

import XCTest
@testable import ecoVandy

final class ecoVandyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().buttons["Sign in with"]/*@START_MENU_TOKEN@*/.press(forDuration: 0.4);/*[[".tap()",".press(forDuration: 0.4);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
