import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class UserTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        stub(condition: isHost("currry.xyz") && isPath("/api/users") && isMethodPOST()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["user" : ["id": 1, "name" : "ogidow", "email": "syuta_ogido@yahoo.co.jp"]],
                statusCode: 200,
                headers: nil
            )
        }

        stub(condition: isHost("currry.xyz") && isPath("/api/auth") && isMethodPOST()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["user" : ["id" : 1, "name" : "testUser", "email" : "test@test.com"], "token" : "ThisIsAuthToken"],
                statusCode: 200,
                headers: nil
            )
        }
        
        stub(condition: isHost("currry.xyz") && isPath("/api/lists") && isMethodGET()){_ in
            return OHHTTPStubsResponse(
                jsonObject: [
                    "lists" : [
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
        logout()
    }

    func testUserCreate() {

        let parameters:  [String : Any] = [
            "user": [
                "name": "ogidow",
                "email": "syuta_ogido@yahoo.co.jp",
                "password": "testtest",
                "password_confirmation": "testtest"
            ]
        ]

        // リクエスト処理を同期的に実行する
        waitUntil { done in
            User.createUser(parameters: parameters){ response in
                XCTAssertEqual("ogidow", response.name)
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
                response.forEach {
                    XCTAssertNotNil($0.id)
                    XCTAssertNotNil($0.name)
                }
                done()
            }
        }
    }
}
