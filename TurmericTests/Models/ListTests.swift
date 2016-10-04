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
            List.getList(id: 1) { response in
                XCTAssertEqual(1, response.id)
                XCTAssertEqual("Friends", response.name)
                done()
            }
        }
    }
    
    func testListMembers() {
        waitUntil { done in
            List.getMembers(id: 1) { response in
                response.forEach {
                    XCTAssertNotNil($0.id)
                    XCTAssertNotNil($0.name)
                    XCTAssertNotNil($0.iconURL)
                }
                done()
            }
        }
    }
}
