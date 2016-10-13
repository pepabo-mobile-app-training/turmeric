//
//  ListDeleteUITest.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ListDeleteUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
        login()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListDeleteLayout() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        app.buttons["追加・削除"].tap()
        
        let listCell = app.tables.cells.element(boundBy: 0)
        let deleteButton = listCell.buttons["deleteButton"]
        let complateButton = app.buttons["完了"]
        
        XCTAssert(deleteButton.exists)
        XCTAssert(complateButton.exists)
        
        deleteButton.tap()
        complateButton.tap()
    }
    
}
