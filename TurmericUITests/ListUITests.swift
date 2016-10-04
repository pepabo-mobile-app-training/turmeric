//
//  ListUITests.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/03.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListLayout() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        
        let listEditButton = app.buttons["追加・削除(仮)"]
        let listCells = app.tables.cells
        
        XCTAssert(listEditButton.exists)
        XCTAssertEqual(3, listCells.count)
    }
}
