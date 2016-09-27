//
//  TurmericTests.swift
//  TurmericTests
//
//  Created by usr0600433 on 2016/09/26.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

@testable import Turmeric

class TurmericTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserCreate (){
        class MocUser: User {
            override class func createUser(parameters: [String : Any], handler: @escaping ((User) -> Void)){
                let user = parameters["user"] as! [String : String]
                handler(User(id: 1, name: user["name"]!))
            }
        }
        let parameters:  [String : Any] = [
            "user": [
                "name": "testUser",
                "email": "test@test.com",
                "password": "hogehoge",
                "password_confirmation": "hogehoge"
            ]
        ]
        
        User.createUser(parameters: parameters){ response in
            XCTAssertEqual("testUser", response.name)
        }
    }
    
}
