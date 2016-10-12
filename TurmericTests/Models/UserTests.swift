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
                switch response {
                case .Success(let user):
                    XCTAssertEqual("Example User", user.name)
                    done()
                default: break
                }
            }
        }
    }

    func testUserMe() {
        waitUntil { done in
            User.getMyUser(){ response in
                switch response {
                case .Success(let user):
                    XCTAssertEqual("Example User", user.name)
                    XCTAssertEqual(100, user.followingCount)
                    XCTAssertEqual(200, user.followersCount)
                    XCTAssertEqual(1000, user.micropostsCount)
                    XCTAssertEqual("https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?s=80", user.iconURL.absoluteString)
                    done()
                default: break
                }
                
            }
        }
    }

    func testUserLogin() {
        waitUntil { done in
            User.authenticate(parameters: ["user": ["email": "test@example.com", "password": "F0oB@rbaz"]]) { response in
                switch response {
                case .Success:
                    XCTAssertEqual("This.Is.Example-Auth-Token", APIClient.token)
                    done()
                default: break
                }
            }
        }
    }

    func testGetMyFeed() {
        login()
        waitUntil { done in
            User.getMyFeed { response in
                switch response {
                case .Success(let feed):
                    feed!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.content)
                        XCTAssertNotNil($0.userId)
                        XCTAssertNotNil($0.user.name)
                    }
                    done()
                default: break
                }
            }
        }
    }

    func testGetMyLists() {
        login()

        waitUntil { done in
            User.getMyLists { response in
                switch response {
                case .Success(let lists):
                    lists!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.name)
                    }
                    done()
                default: break
                }
            }
        }
    }

    func testFollowing() {
        login()

        waitUntil { done in
            User.getFollowing(id: 1) { response in
                switch response {
                case .Success(let following):
                    following!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.name)
                    }
                    done()
                default: break
                }
            }
        }
    }

    func testFollowers() {
        login()

        waitUntil { done in
            User.getFollowers(id: 1) { response in
                switch response {
                case .Success(let followers):
                    followers!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.name)
                    }
                    done()
                default: break
                }
            }
        }
    }
}
