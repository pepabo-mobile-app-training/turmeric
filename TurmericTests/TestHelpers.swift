import Foundation
import Nimble

@testable import Turmeric

func login(parameters : [String : Any?]){
    waitUntil { done in
        User.authenticate(parameters: parameters) { response in
            done()
        }
    }
}

func logout() {
    APIClient.token = nil
}
