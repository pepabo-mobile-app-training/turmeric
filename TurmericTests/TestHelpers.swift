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
            fileAtPath: OHPathForFileInBundle("MicropostsShow.json", Bundle.init(identifier: "com.pepabo.training.TurmericTests")!)!,
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
}
