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
                jsonObject: ["user" : ["id": 1, "name" : "testUser", "email": "test@test.com"]],
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
        APIClient.token = nil
    }

    func testUserCreate() {

        let parameters:  [String : Any] = [
            "user": [
                "name": "testUser",
                "email": "test@test.com",
                "password": "hogehoge",
                "password_confirmation": "hogehoge"
            ]
        ]

        // リクエスト処理を同期的に実行する
        waitUntil { done in
            User.createUser(parameters: parameters){ response in
                XCTAssertEqual("testUser", response.name)
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
        
        let userParameters: [String : Any?] = ["user" : ["email" : "syuta_ogido@yahoo.co.jp", "password" : "testtest"]]
        login(parameters: userParameters)
        
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
