import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class MicropostTests: XCTestCase {
    override func setUp() {
        super.setUp()

        stub(condition: isHost("currry.xyz") && isPath("/api/microposts/100") && isMethodGET()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["micropost" : ["id" : 100, "user_id" : 1, "content" : "testContent", "picture" : "https://example.com/picture.jpg"]],
                statusCode: 200,
                headers: nil
            )
        }
        stub(condition: isHost("currry.xyz") && isPath("/api/microposts/101") && isMethodGET()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["micropost" : ["id" : 101, "user_id" : 2, "content" : "testContent2"]],
                statusCode: 200,
                headers: nil
            )
        }
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
                XCTAssertEqual("testContent", response.content)
                XCTAssertEqual("https://example.com/picture.jpg", response.picture?.absoluteString)
                done()
            }
        }
        waitUntil { done in
            Micropost.getMicropost(id: 101) { response in
                XCTAssertEqual(101, response.id)
                XCTAssertEqual(2, response.userId)
                XCTAssertEqual("testContent2", response.content)
                XCTAssertNil(response.picture)
                done()
            }
        }
    }
}
