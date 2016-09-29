import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    let id: Int
    let name: String
    let email: String
    
    var followingCount: Int?
    var followersCount: Int?
    var micropostsCount: Int?
    var iconUrl: NSURL?
    
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    init(json: JSON) {
        self.id   = json["user"]["id"].int!
        self.name = json["user"]["name"].string!
        self.email = json["user"]["email"].string!
        
        self.followingCount  = json["user"]["following_count"].intValue
        self.followersCount  = json["user"]["followers_count"].intValue
        self.micropostsCount = json["user"]["microposts_count"].intValue
        self.iconUrl         = NSURL(string: json["user"]["icon_url"].stringValue)
    }

    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(json: json))
        }
    }
    
    static func getMyUser(handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersMe, parameters: [:]) { json in
            handler(User(json: json))
        }
    }
    
    static func authenticate(parameters: Parameters, handler: @escaping (Any?) -> Void) {
        APIClient.request(endpoint: Endpoint.Auth, parameters: parameters) { json in
            APIClient.token = json["token"].string!
            handler(nil)
        }
    }
}
