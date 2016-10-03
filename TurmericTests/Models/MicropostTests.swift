import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class MicropostTests: XCTestCase {
    override func setUp() {
        super.setUp()
        enableHTTPStubsResponse()
    }

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testGetMicropost() {
        waitUntil { done in
            Micropost.getMicropost(id: 100) { response in
                XCTAssertEqual(100, response.id)
                XCTAssertEqual(1, response.userId)
                XCTAssertEqual("I just ate an orange!", response.content)
                XCTAssertEqual("https://example.com/picture.jpg", response.picture?.absoluteString)
                done()
            }
        }
    }
}
