import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    var id: Int
    var name: String
    var email: String
    
    init(id: Int, name: String, email: String, token: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    init(json: JSON) {
        self.id   = json["user"]["id"].int!
        self.name = json["user"]["name"].string!
        self.email = json["user"]["email"].string!
    }

    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(json: json))
        }
    }
    
    static func authenticate(parameters: Parameters, handler: @escaping (Any?) -> Void) {
        APIClient.request(endpoint: Endpoint.Auth, parameters: parameters) { json in
            APIClient.token = json["token"].stringValue
            handler(nil)
        }
    }
}
