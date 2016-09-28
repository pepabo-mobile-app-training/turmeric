import XCTest
import OHHTTPStubs
import Nimble

@testable import Turmeric

class TurmericTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        stub(condition: isHost("currry.xyz") && isPath("/api/users") && isMethodPOST()){_ in
            return OHHTTPStubsResponse(
                jsonObject: ["user" : ["name" : "testUser"]],
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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
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
        
        waitUntil { done in
            User.authenticate(parameters: ["user" : ["email" : "syuta_ogido@yahoo.co.jp", "password" : "testtest"]]) { res in
                XCTAssertEqual("testUser", CurrentUser.name)
                XCTAssertEqual("test@test.com", CurrentUser.email)
                XCTAssertEqual("ThisIsAuthToken", CurrentUser.loadToken())
                done()
            }
        }
    }
}
