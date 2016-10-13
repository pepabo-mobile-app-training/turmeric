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
        // 最初のセル
        let firstCell = micropostCells.element(boundBy: 0)
        XCTAssert(firstCell.staticTexts["Example User"].exists)
        XCTAssert(firstCell.staticTexts["Writing a short test"].exists)
        // 最後のセル
        let lastCell = micropostCells.element(boundBy: micropostCells.count - 1)
        XCTAssert(lastCell.staticTexts["Michael"].exists)
        XCTAssert(lastCell.staticTexts["Rerum ut laborum at ab in itaque quos."].exists)
    }

    // リストフィード(リストに追加されたユーザーの投稿)
    func testListFeed() {
        let app = XCUIApplication()
        app.tabBars.buttons["ホーム"].tap()
        let swipeTab = app.navigationBars["Turmeric.HomeView"].collectionViews
        // Friendsリストのフィードに移動
        swipeTab.staticTexts["Friends"].tap()
        let micropostCells = app.tables.cells
        XCTAssertEqual(9, micropostCells.count)
        // 最初のセル
        let firstCell = micropostCells.element(boundBy: 0)
        XCTAssert(firstCell.staticTexts["ListFeed Test User"].exists)
        XCTAssert(firstCell.staticTexts["ListFeed desu."].exists)
        // 最後のセル
        let lastCell = micropostCells.element(boundBy: micropostCells.count - 1)
        XCTAssert(lastCell.staticTexts["Michael List"].exists)
        XCTAssert(lastCell.staticTexts["リストフィードです"].exists)
    }

    // プロフィールフィード(プロフィールページの自分の投稿)
    func testProfileFeed() {
        let app = XCUIApplication()
        app.tabBars.buttons["プロフィール"].tap()
        let micropostCells = app.tables.cells
        XCTAssertEqual(8, micropostCells.count)
        // 最初のセル
        let firstCell = micropostCells.element(boundBy: 0)
        XCTAssert(firstCell.staticTexts["Profile Test User"].exists)
        XCTAssert(firstCell.staticTexts["投稿8"].exists)
        // 最後のセル
        let lastCell = micropostCells.element(boundBy: micropostCells.count - 1)
        XCTAssert(lastCell.staticTexts["Profile Test User"].exists)
        XCTAssert(lastCell.staticTexts["投稿1"].exists)
    }

    // 他人のプロフィールフィード
    // 投稿をタップしたらその人のプロフィールに飛ぶこともテストする
    func testOtherProfileFeed() {
        let app = XCUIApplication()
        let micropostCells = app.tables.cells

        // 最後のセル
        let lastCell = micropostCells.element(boundBy: micropostCells.count - 1)
        lastCell.staticTexts["Michael"].tap()
        XCTAssert(app.staticTexts["プロフィール"].exists) // プロフ画面タイトル
    }
}
