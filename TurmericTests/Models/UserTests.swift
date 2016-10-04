import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class UserTests: XCTestCase {

    override func setUp() {
        super.setUp()
        enableHTTPStubs()

        stub(condition: isHost("currry.xyz") && isPath("/api/auth") && isMethodPOST()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["user" : ["id" : 1, "name" : "testUser", "email" : "test@test.com"], "token" : "ThisIsAuthToken"],
                statusCode: 200,
                headers: nil
            )
        }
        
        stub(condition: isHost("currry.xyz") && isPath("/api/users/me") && isMethodGET()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["user" : ["id" : 1, "name" : "testUser", "email" : "test@test.com", "following_count": 100, "followers_count": 200, "microposts_count": 1000, "icon_url": "https://example.com/example.jpg"]],
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
    
    func testUserMe() {
        waitUntil { done in
            User.getMyUser(){ response in
                XCTAssertEqual("testUser", response.name)
                XCTAssertEqual(100, response.followingCount)
                XCTAssertEqual(200, response.followersCount)
                XCTAssertEqual(1000, response.micropostsCount)
                XCTAssertEqual("https://example.com/example.jpg", response.iconURL)
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
