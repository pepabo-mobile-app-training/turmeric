//
//  PostUITests.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class PostUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPost() {
        let app = XCUIApplication()
        app.tabBars.buttons["投稿"].tap()
        
        let posttextviewTextView = app.textViews["PostTextView"]
        posttextviewTextView.tap()
        posttextviewTextView.typeText("can enter text....")
        app.toolbars.buttons["投稿"].tap()
    }
    
    func testClose() {
        let app = XCUIApplication()
        app.tabBars.buttons["投稿"].tap()
        app.buttons["閉じる"].tap()
    }
    
}
