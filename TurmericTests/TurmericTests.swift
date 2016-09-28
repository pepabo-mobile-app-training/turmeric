//
//  TurmericTests.swift
//  TurmericTests
//
//  Created by usr0600433 on 2016/09/26.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class TurmericTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        stub(condition: isHost("currry.xyz") && isPath("/api/users") && isMethodPOST()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["user" : ["name" : "testUser"]],
                statusCode: 200,
                headers: nil
            )
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testUserCreate (){
       
        let parameters:  [String : Any] = [
            "user": [
                "name": "testUser",
                "email": "test@test.com",
                "password": "hogehoge",
                "password_confirmation": "hogehoge"
            ]
        ]
        waitUntil { done in
            User.createUser(parameters: parameters){ response in
                XCTAssertEqual("testUser", response.name)
                done()
            }
        }
    }
    
}
