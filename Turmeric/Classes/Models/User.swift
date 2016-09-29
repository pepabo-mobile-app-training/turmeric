import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(json: JSON) {
        self.id   = json["user"]["id"].intValue
        self.name = json["user"]["name"].stringValue
    }

    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(json: json))
        }
    }
}
