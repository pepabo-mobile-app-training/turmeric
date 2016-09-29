import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class ListTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        stub(condition: isHost("currry.xyz") && isPath("/api/lists") && isMethodGET()){_ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "lists" :[
                        ["id" : 1, "name" : "friend"],
                        ["id" : 2, "name" : "curry"]
                    ]
                ],
                statusCode: 200,
                headers: nil
            )
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testMyGetLists() {
        let userParams = ["user" : ["email" : "syuta_ogido@yahoo.co.jp", "password" : "testtest"]]
        waitUntil() {done in
            User.authenticate(parameters: userParams) { response in
                done()
            }
        }
        
        waitUntil { done in
            User.getMyLists { response in
                response.forEach {
                    XCTAssertNotNil($0.id)
                    XCTAssertNotNil($0.name)
                }
                done()
            }
        }
    }
    
}
