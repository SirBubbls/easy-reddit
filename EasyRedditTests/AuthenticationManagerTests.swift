//
//  AuthenticationTests.swift
//  EasyRedditTests
//
//  Created by Lucas Sas on 04.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import XCTest
import EasyReddit

class AuthenticationManagerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWrongClientID() {
        AuthenticationManager.shared.clientId = "WrongClientID"
        XCTAssertFalse(AuthenticationManager.shared.viableToken())
    }
    
    func testLoadToken() {
//        AuthenticationManager.shared.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
