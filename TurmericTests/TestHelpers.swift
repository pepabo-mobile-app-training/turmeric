import Foundation
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
