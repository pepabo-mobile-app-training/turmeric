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

    // ホームフィード(通常のタイムライン)
    func testHomeFeed() {
        let app = XCUIApplication()
        app.tabBars.buttons["ホーム"].tap()
        let micropostCells = app.tables.cells
        XCTAssertEqual(10, micropostCells.count)
        XCTAssert(micropostCells.staticTexts["Writing a short test"].exists)
    }

    // リストフィード(リストに追加されたユーザーの投稿)
    func testListFeed() {
        let app = XCUIApplication()
        app.tabBars.buttons["ホーム"].tap()
        let swipeTab = app.navigationBars["Turmeric.HomeView"].collectionViews
        // Friendsリストのフィードに移動
        swipeTab.staticTexts["Friends"].tap()
        let micropostCells = app.tables.cells
        // TODO: リストのフィードが取得できるようになったら個数やテキストを変更する
        XCTAssertEqual(10, micropostCells.count)
        XCTAssert(micropostCells.staticTexts["Writing a short test"].exists)
    }

    // プロフィールフィード(プロフィールページの自分の投稿)
    func testProfileFeed() {
        let app = XCUIApplication()
        app.tabBars.buttons["プロフィール"].tap()
        let micropostCells = app.tables.cells
        // TODO: プロフィールフィードが取得できるようになったら個数やテキストを変更する
        XCTAssertEqual(10, micropostCells.count)
        XCTAssert(micropostCells.staticTexts["Writing a short test"].exists)
    }
}
