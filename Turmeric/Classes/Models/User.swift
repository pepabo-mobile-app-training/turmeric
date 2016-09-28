import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    var id: Int
    var name: String
    var email: String
    private var token: String? = nil
    
    init(id: Int, name: String, email: String, token: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    init(json: JSON) {
        self.id   = json["user"]["id"].intValue
        self.name = json["user"]["name"].stringValue
        self.email = json["user"]["emain"].stringValue
    }

    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(json: json))
        }
    }
    
    static func authenticate(parameters: Parameters, handler: @escaping (Any?) -> Void) {
        APIClient.request(endpoint: Endpoint.Auth, parameters: parameters) { json in
            APIClient.saveToken(token: json["token"].stringValue)
            handler(nil)
        }
    }
}
