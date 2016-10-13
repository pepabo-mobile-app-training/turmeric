//
//  ListCreateUITests.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/10/12.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ListCreateUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
        
        login()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListCreate() {
        let app = XCUIApplication()
        app.tabBars.buttons["リスト"].tap()
        app.buttons["追加・削除"].tap()
        app.buttons["Add"].tap()
        
        let cancelButton = app.buttons["キャンセル"]
        let saveButton = app.buttons["保存"]
        let cell = app.tables.cells.element(boundBy: 0)
        
        XCTAssert(cancelButton.exists)
        XCTAssert(saveButton.exists)
        XCTAssert(cell.exists)
        
    }
    
}
