import XCTest

class HomeUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHomeTabLayout() {
        let app = XCUIApplication()
        // ホーム画面が初期状態で選択されていることをテスト
        XCTAssert(app.tabBars.buttons["ホーム"].exists)
        XCTAssert(app.tabBars.buttons["ホーム"].isSelected)

        // 上部のスワイプ切り替えタブ
        let swipeTab = app.navigationBars["Turmeric.HomeView"].collectionViews
        XCTAssertEqual(2, swipeTab.cells.count)
        swipeTab.staticTexts["Friends"].tap()
        swipeTab.staticTexts["Home"].tap()
   }
}
