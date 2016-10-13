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
    
    func testExample() {
        let app = XCUIApplication()
        let tables = app.tables
        
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
