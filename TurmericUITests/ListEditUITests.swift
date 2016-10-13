//
//  ListEditUITests.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/06.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ListEditUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
        login()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListEditLayout() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        let cell = app.tables.cells.element(boundBy: 0)
        cell.tap()
        app.buttons["編集"].tap()
        
        let updateButton = app.buttons["保存"]
        let cancelButton = app.buttons["キャンセル"]
        
        let membersCells = app.tables.cells
        let listNameField = app.textFields["listNameField"]
        
        XCTAssert(updateButton.exists)
        XCTAssert(cancelButton.exists)
        XCTAssertEqual(2, membersCells.count)
        XCTAssertEqual("Friends", listNameField.value as! String)
    }
}
