//
//  ProfileUITests.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/09/29.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import XCTest

class ProfileUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testProfileLayout() {
        //プロフィールページへ
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["プロフィール"].tap()
        
        let profileEditButton           = app.buttons["profileEditButton"]
        let profileFollowingCountButton = app.buttons["profileFollowingCountButton"]
        let profileFollowersCountButton = app.buttons["profileFollowersCountButton"]
        let profileImage                = app.images["profileImage"]
        let profileMicropostsCountLabel = app.staticTexts["profileMicropostsCountLabel"]
        
        XCTAssert(profileEditButton.exists)
        XCTAssert(profileFollowersCountButton.exists)
        XCTAssert(profileFollowingCountButton.exists)
        XCTAssert(profileMicropostsCountLabel.exists)
        XCTAssert(profileImage.exists)
        
    }
    
}
