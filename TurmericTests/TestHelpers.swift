import Foundation
import OHHTTPStubs
import Nimble

@testable import Turmeric

func login(){
    waitUntil { done in
        User.authenticate(parameters: ["user": ["email": "test@example.com", "password": "F0oB@rbaz"]]) { response in
            done()
        }
    }
}

func logout() {
    User.logout()
}
