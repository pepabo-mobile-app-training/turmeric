//
//  OthersProfileUITest.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/11.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class OthersProfileUITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOthersProfileLayout() {
        //他人プロフィールページへ
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["プロフィール"].tap()
        app.buttons["profileFollowingCountButton"].tap()
        
        app.tables.staticTexts["ry023"].tap()
        
        let profileFollowingCountButton = app.buttons["profileFollowingCountButton"]
        let profileFollowersCountButton = app.buttons["profileFollowersCountButton"]
        let profileImage                = app.images["profileImage"]
        let profileMicropostsCountLabel = app.staticTexts["profileMicropostsCountLabel"]
        
        XCTAssert(profileFollowersCountButton.exists)
        XCTAssertEqual(profileFollowersCountButton.label, "200")
        
        XCTAssert(profileFollowingCountButton.exists)
        XCTAssertEqual(profileFollowingCountButton.label, "100")
        
        XCTAssert(profileMicropostsCountLabel.exists)
        XCTAssertEqual(profileMicropostsCountLabel.label, "1000")
        
        XCTAssert(profileImage.exists)

    }
}
