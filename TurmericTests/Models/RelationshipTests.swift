import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class RelationshipTests: XCTestCase {
    override func setUp() {
        super.setUp()
        enableHTTPStubs()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
        logout()
    }

    func testFollow() {
        login()
        
        waitUntil { done in
            Relationship.createRelationship(userID: 102){
                done()
            }
        }
    }
    
    func testUnfollow() {
        login()
        
        waitUntil { done in
            Relationship.destroyRelationship(userID: 101){
                done()
            }
        }
    }
}
