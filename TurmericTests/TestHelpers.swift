import Foundation
import Nimble

internal func login(parameters : [String : Any?]){
    waitUntil { done in
        User.authenticate(parameters: parameters) { response in
            XCTAssertEqual("ThisIsAuthToken", APIClient.token)
            done()
        }
    }
}
