import XCTest
import Nimble

@testable import Turmeric

class ListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        enableHTTPStubs()
    }
    
    override func tearDown() {
        super.tearDown()
        disableHTTPStubs()
    }
    
    func testListShow() {
        waitUntil { done in
            List.getList(id: 100) { response in
                XCTAssertEqual(100, response.id)
                XCTAssertEqual("friend", response.name)
                done()
            }
        }
    }
    
}
