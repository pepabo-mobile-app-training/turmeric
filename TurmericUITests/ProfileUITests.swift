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
        XCTAssertEqual(profileFollowersCountButton.label, "200")
        
        XCTAssert(profileFollowingCountButton.exists)
        XCTAssertEqual(profileFollowingCountButton.label, "100")
        
        XCTAssert(profileMicropostsCountLabel.exists)
        XCTAssertEqual(profileMicropostsCountLabel.label, "1000")
        
        XCTAssert(profileImage.exists)
    }
    
    func testMyFollowers(){
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons["プロフィール"].tap()
        app.buttons["profileFollowersCountButton"].tap()
        
        XCTAssert(app.staticTexts["ry023"].exists)
        XCTAssert(app.staticTexts["shimoju"].exists)
    }
    
    func testMyFollowing(){
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons["プロフィール"].tap()
        app.buttons["profileFollowingCountButton"].tap()
        
        XCTAssert(app.staticTexts["ry023"].exists)
        XCTAssert(!app.staticTexts["shimoju"].exists)
    }
}
