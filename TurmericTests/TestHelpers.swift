import Foundation
import OHHTTPStubs
import Nimble

@testable import Turmeric

func login(){
    waitUntil { done in
        User.authenticate(parameters: ["user" : ["email" : "syuta_ogido@yahoo.co.jp", "password" : "testtest"]]) { response in
            done()
        }
    }
}

func logout() {
    APIClient.token = nil
}

func enableHTTPStubsResponse() {
    stub(condition: isHost("currry.xyz") && isPath("/api/microposts/100") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MicropostsShow.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/microposts/101") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MicropostsShow_withPicture.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
}

private func stubFilePath(name: String) -> String {
    return OHPathForFileInBundle(name, Bundle.init(identifier: "com.pepabo.training.TurmericTests")!)!
}
