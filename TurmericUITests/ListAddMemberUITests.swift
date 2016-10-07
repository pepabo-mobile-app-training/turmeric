//
//  ListAddMemberUITests.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/07.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ListAddMemberUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListAddMemberLayout() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        let cell = app.tables.cells.element(boundBy: 0)
        cell.tap()
        app.buttons["編集"].tap()
        app.buttons["addButton"].tap()
        
        let cancelButton = app.buttons["キャンセル"]
        let followingCells = app.tables.cells.element(boundBy: 0)
        let addButton = followingCells.buttons["addButton"]
        XCTAssert(cancelButton.exists)
        XCTAssert(addButton.exists)
        
        
    }
    
}
