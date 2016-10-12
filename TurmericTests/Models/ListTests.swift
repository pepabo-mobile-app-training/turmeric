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
                switch response {
                case .Success(let list):
                    XCTAssertEqual(1, list.id)
                    XCTAssertEqual("Friends", list.name)
                    done()
                default: break
                }
            }
        }
    }
    
    func testListMembers() {
        waitUntil { done in
            List.getMembers(id: 1) { response in
                switch response {
                case .Success(let members):
                    members.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.name)
                        XCTAssertNotNil($0.iconURL)
                    }
                    done()
                default: break
                }
            }
        }
    }
    
    func testListUpdate() {
        let parameters = ["list" : ["name" : "myFriends"]]
        waitUntil { done in
            List.update(id: 1, parameters: parameters) { response in
                switch response {
                case .Success(let list):
                    XCTAssertEqual(1, list.id)
                    XCTAssertEqual("myFriends", list.name)
                    done()
                default: break
                }
            }
        }
    }
    
    func testDeleteMembers() {
        waitUntil { done in
            List.deleteMember(listId: 1, memberId: 101) { response in
                switch response {
                case .Success:
                    done()
                default: break
                }
            }
        }
    }
    
    func testAddMembers() {
        waitUntil { done in
            List.addMember(id: 1, parameters: ["user_id" : 102]) { response in
                switch response {
                case .Success:
                    done()
                default: break
                }
            }
        }
    }
    
    func testDeleteList() {
        waitUntil { done in
            List.deleteList(id: 1) {response in
                switch response {
                case .Success:
                    done()
                default: break
                }
            }
        }
    }
    
    func testListCreate() {
        waitUntil { done in
            List.createList(parameters: ["list" : ["name" : "engineer"]]) {response in
                switch response {
                case .Success(let list):
                    XCTAssertEqual(list.name, "engineer")
                    done()
                default: break
                }
            }
        }
    }
}
