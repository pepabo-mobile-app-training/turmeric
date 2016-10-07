import XCTest

class FeedUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHomeFeed() {
        let app = XCUIApplication()
        // ホームフィード(通常のタイムライン)
        app.tabBars.buttons["ホーム"].tap()
        let micropostCells = app.tables.cells
        XCTAssertEqual(10, micropostCells.count)
        XCTAssert(micropostCells.staticTexts["Writing a short test"].exists)
    }

    func testListFeed() {
        let app = XCUIApplication()
        app.tabBars.buttons["ホーム"].tap()
        let swipeTab = app.navigationBars["Turmeric.HomeView"].collectionViews
        // Friendsリストのフィードに移動
        swipeTab.staticTexts["Friends"].tap()
        let micropostCells = app.tables.cells
        // TODO: リストのフィードが取得できるようになったら、リストフィードにしかないテキストがあるかを確認する
        XCTAssertEqual(10, micropostCells.count)
        XCTAssert(micropostCells.staticTexts["Writing a short test"].exists)
    }
}
