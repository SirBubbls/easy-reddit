//
//  OAuthTests.swift
//  EasyRedditTests
//
//  Created by Lucas Sas on 04.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import XCTest
import EasyReddit

class OAuthTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOAuthInit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let token = OAuthToken(accessToken: "123456", refreshToken: "9876")
        
        XCTAssert(token.accessToken == "123456")
        XCTAssert(token.refreshToken == "9876")
    }
    
    
    func testOAuthInitJson() {
        let jsonData: String = """
{
    "access_token": "Your access token",
    "token_type": "bearer",
    "expires_in": "Unix Epoch Seconds",
    "scope": "A scope string",
    "refresh_token": "Your refresh token"
}
"""
        let json = JSON(parseJSON: jsonData)
        
        let token = OAuthToken(response: json)
        
        XCTAssert(token.accessToken == "Your access token")
        XCTAssert(token.refreshToken == "Your refresh token")
        
    }

}
