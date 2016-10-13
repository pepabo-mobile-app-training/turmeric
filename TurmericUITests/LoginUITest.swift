//
//  LoginUITest.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/13.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class LoginUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLogin() {
        let app = XCUIApplication()
        login()
        
        let homeTab = app.tabBars.buttons["ホーム"]
        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: homeTab, handler: nil)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}

extension XCTestCase {
    func login() {
        let app = XCUIApplication()
        let emailField = app.tables.cells.element(boundBy: 0)
        let passwordField = app.tables.cells.element(boundBy: 1)
        let loginButton = app.tables.cells.element(boundBy: 2)
        
        
        emailField.tap()
        emailField.typeText("test@example.com")
        
        passwordField.tap()
        passwordField.typeText("F0oB@rbaz")
        
        loginButton.tap()
    }
}
