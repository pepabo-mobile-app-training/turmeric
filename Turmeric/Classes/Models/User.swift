import Foundation
import Alamofire
import SwiftyJSON

class User {
    
    let id: Int
    let name: String
    let email: String
    
    let followingCount: Int?
    let followersCount: Int?
    let micropostsCount: Int?
    let iconUrl: NSURL?
    
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        
        self.followersCount  = nil
        self.followingCount  = nil
        self.micropostsCount = nil
        
        self.iconUrl = nil
    }
    
    init(json: JSON) {
        self.id   = json["user"]["id"].int!
        self.name = json["user"]["name"].string!
        self.email = json["user"]["email"].string!
        
        self.followingCount  = json["user"]["following_count"].int
        self.followersCount  = json["user"]["followers_count"].int
        self.micropostsCount = json["user"]["microposts_count"].int
        
        if let iconUrl = json["user"]["icon_url"].string {
            self.iconUrl = NSURL(string: iconUrl)
        } else {
            self.iconUrl = nil
        }
        
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
