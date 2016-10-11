import XCTest
import Nimble

@testable import Turmeric

class MicropostTests: XCTestCase {
    override func setUp() {
        super.setUp()
        enableHTTPStubs()
    }

    override func tearDown() {
        super.tearDown()
        disableHTTPStubs()
    }
    
    func testPostMicropost() {
        let parameters: [String: Any] = [
            "content": "I just ate an orange!"
        ]
        
        waitUntil { done in
            Micropost.postMicropost(parameters: parameters){ response in
                XCTAssertEqual("I just ate an orange!", response.content)
                done()
            }
        }
    }

    func testGetMicropost() {
        waitUntil { done in
            Micropost.getMicropost(id: 100) { response in
                XCTAssertEqual(100, response.id)
                XCTAssertEqual(1, response.userId)
                XCTAssertEqual("I just ate an orange!", response.content)
                XCTAssertNil(response.picture)
                // マイクロポストにユーザー情報が含まれているかテスト
                XCTAssertEqual("Example User", response.user.name)
                done()
            }
        }
        waitUntil { done in
            Micropost.getMicropost(id: 101) { response in
                XCTAssertEqual(101, response.id)
                XCTAssertEqual(2, response.userId)
                XCTAssertEqual("With picture", response.content)
                XCTAssertEqual("https://example.com/picture.jpg", response.picture?.absoluteString)
                XCTAssertEqual("Michael", response.user.name)
                done()
            }
        }
    }
}
