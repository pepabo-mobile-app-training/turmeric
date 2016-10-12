import XCTest
import Nimble

@testable import Turmeric

class MicropostTests: XCTestCase {
    override func setUp() {
        super.setUp()
        enableHTTPStubs()
    }

    override func tearDown() {
        super.tearDown()
        disableHTTPStubs()
    }
    
    func testPostMicropost() {
        let parameters: [String: Any] = [
            "content": "I just ate an orange!"
        ]
        
        waitUntil { done in
            Micropost.postMicropost(parameters: parameters){ response in
                switch response {
                case .Success(let micropost):
                    XCTAssertEqual("I just ate an orange!", micropost.content)
                    XCTAssertEqual("Example User", micropost.user.name)
                    done()
                default: break
                }
            }
        }
    }

    func testGetMicropost() {
        waitUntil { done in
            Micropost.getMicropost(id: 100) { response in
                switch response {
                case .Success(let micropost):
                    XCTAssertEqual(100, micropost.id)
                    XCTAssertEqual(1, micropost.userId)
                    XCTAssertEqual("I just ate an orange!", micropost.content)
                    XCTAssertNil(micropost.picture)
                    XCTAssertEqual("Example User", micropost.user.name)
                    done()
                default: break
                }
            }
        }
        waitUntil { done in
            Micropost.getMicropost(id: 101) { response in
                switch response {
                case .Success(let micropost):
                    XCTAssertEqual(101, micropost.id)
                    XCTAssertEqual(2, micropost.userId)
                    XCTAssertEqual("With picture", micropost.content)
                    XCTAssertEqual("https://example.com/picture.jpg", micropost.picture?.absoluteString)
                    XCTAssertEqual("Michael", micropost.user.name)
                    done()
                default: break
                }
            }
        }
    }

    func testGetFeed() {
        // ホームフィード(通常のタイムライン)
        waitUntil { done in
            Micropost.getFeed(endpoint: Endpoint.MyFeed) { response in
                switch response {
                case .Success(let feed):
                    feed!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.content)
                        XCTAssertNotNil($0.userId)
                        XCTAssertNotNil($0.user.name)
                    }
                    // ユーザー名を確認して、エンドポイントごとに適切なレスポンスが返ってきているかテスト
                    XCTAssertEqual("Example User", feed![0].user.name)
                    done()
                default: break
                }
            }
        }
        // リストフィード(リストに追加されたユーザーの投稿)
        waitUntil { done in
            Micropost.getFeed(endpoint: Endpoint.ListFeed(1)) { response in
                switch response {
                case .Success(let feed):
                    feed!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.content)
                        XCTAssertNotNil($0.userId)
                        XCTAssertNotNil($0.user.name)
                    }
                    XCTAssertEqual("ListFeed Test User", feed![0].user.name)
                    done()
                default: break
                }
            }
        }
        // プロフィールフィード(ユーザーが投稿したマイクロポスト一覧)
        waitUntil { done in
            Micropost.getFeed(endpoint: Endpoint.UsersMicroposts(1)) { response in
                switch response {
                case .Success(let feed):
                    feed!.forEach {
                        XCTAssertNotNil($0.id)
                        XCTAssertNotNil($0.content)
                        XCTAssertNotNil($0.userId)
                        XCTAssertNotNil($0.user.name)
                    }
                    XCTAssertEqual("Profile Test User", feed![0].user.name)
                    done()
                default: break
                }
            }
        }
    }
}
