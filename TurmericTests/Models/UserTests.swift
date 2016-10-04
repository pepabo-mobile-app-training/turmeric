import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class UserTests: XCTestCase {

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

    func testUserCreate() {
        let parameters:  [String : Any] = [
            "user": [
                "name": "Example User",
                "email": "user@example.com",
                "password": "testtest",
                "password_confirmation": "testtest"
            ]
        ]

        // リクエスト処理を同期的に実行する
        waitUntil { done in
            User.createUser(parameters: parameters){ response in
                XCTAssertEqual("Example User", response.name)
                done()
            }
        }
    }

    func testUserLogin() {
        waitUntil { done in
            User.authenticate(parameters: ["user" : ["email" : "syuta_ogido@yahoo.co.jp", "password" : "testtest"]]) { response in
                XCTAssertEqual("ThisIsAuthToken", APIClient.token)
                done()
            }
        }
    }
    
    func testGetMyLists() {
        login()
        
        waitUntil { done in
            User.getMyLists { response in
                response!.forEach {
                    XCTAssertNotNil($0.id)
                    XCTAssertNotNil($0.name)
                }
                done()
            }
        }
    }
}
