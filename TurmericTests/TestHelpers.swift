import Foundation
import Nimble

@testable import Turmeric

internal func login(parameters : [String : Any?]){
    waitUntil { done in
        User.authenticate(parameters: parameters) { response in
            done()
        }
    }
}
