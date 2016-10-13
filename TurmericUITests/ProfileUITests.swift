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
    
    func testMyFollowers(){
        // ページに移動
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["プロフィール"].tap()
        app.buttons["profileFollowersCountButton"].tap()
        
        // ユーザ名とフォロー/アンフォローボタンを確認
        XCTAssert(app.staticTexts["ry023"].exists)
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"ry023").buttons["アンフォロー"].exists)
        
        XCTAssert(app.staticTexts["shimoju"].exists)
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"shimoju").buttons["フォロー"].exists)
        
        //アンフォローしたらフォローボタンに変わる
        app.tables.cells.containing(.staticText, identifier:"ry023").buttons["アンフォロー"].tap()
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"ry023").buttons["フォロー"].exists)
        
        //フォローしたらアンフォローボタンに変わる
        app.tables.cells.containing(.staticText, identifier:"shimoju").buttons["フォロー"].tap()
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"shimoju").buttons["アンフォロー"].exists)
    }
    
    func testMyFollowing(){
        // ページに移動
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["プロフィール"].tap()
        app.buttons["profileFollowingCountButton"].tap()
        
        // ユーザ名とアンフォローボタンを確認
        XCTAssert(app.staticTexts["ry023"].exists)
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"ry023").buttons["アンフォロー"].exists)
        
        XCTAssert(!app.staticTexts["shimoju"].exists)   // フォローしていないユーザは表示されない
        
        //アンフォローしたらフォローボタンに変わる
        app.tables.cells.containing(.staticText, identifier:"ry023").buttons["アンフォロー"].tap()
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"ry023").buttons["フォロー"].exists)
        
        //フォローしたらアンフォローボタンに変わる
        app.tables.cells.containing(.staticText, identifier:"ry023").buttons["フォロー"].tap()
        XCTAssert(app.tables.cells.containing(.staticText, identifier:"ry023").buttons["アンフォロー"].exists)
    }
}
