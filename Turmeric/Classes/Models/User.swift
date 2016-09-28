import Foundation
import Alamofire

class User {
    
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(id: json["user"]["id"].intValue, name: json["user"]["name"].stringValue))
        }
    }
}
