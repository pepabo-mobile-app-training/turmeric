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
    
    func testListMembers() {
        waitUntil { done in
            List.getMembers(id: 100) { response in
                response!.forEach {
                    XCTAssertNotNil($0.id)
                    XCTAssertNotNil($0.name)
                    XCTAssertNotNil($0.iconURL)
                }
                done()
            }
        }
    }
}
