//
//  ListDetailUITests.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/04.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ListDetailUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
        login()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListDetailLayout() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        let cell = app.tables.cells.element(boundBy: 0)
        cell.tap()
        
        let editButton = app.buttons["編集"]
        let membersCells = app.tables.cells
        let listNameLabel = app.staticTexts["listNameLabel"]
        
        XCTAssert(editButton.exists)
        XCTAssertEqual(2, membersCells.count)
        XCTAssertEqual("Friends", listNameLabel.label)
        
    }
    
}
