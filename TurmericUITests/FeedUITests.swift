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
    }
}
