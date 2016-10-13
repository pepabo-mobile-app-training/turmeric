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
        
        continueAfterFailure = false
        XCUIApplication().launch()
        login()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListLayout() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        
        let listEditButton = app.buttons["追加・削除"]
        let listCells = app.tables.cells
        
        XCTAssert(listEditButton.exists)
        XCTAssertEqual(3, listCells.count)
    }
}
