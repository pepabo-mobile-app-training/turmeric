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
    let iconURL: NSURL?
    
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
        
        self.followersCount  = nil
        self.followingCount  = nil
        self.micropostsCount = nil
        
        self.iconURL = nil
    }

    init(json: JSON) {
        self.id = json["id"].int!
        self.name = json["name"].string!
        self.email = json["email"].string!
        
        self.followingCount  = json["following_count"].int
        self.followersCount  = json["followers_count"].int
        self.micropostsCount = json["microposts_count"].int
        
        if let iconURL = json["icon_url"].string {
            self.iconURL = NSURL(string: iconURL)
        } else {
            self.iconURL = nil
        }
        
    }

    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(json: json["user"]))
        }
    }
    
    static func getMyUser(handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersMe, parameters: [:]) { json in
            handler(User(json: json["user"]))
        }
    }

    static func authenticate(parameters: Parameters, handler: @escaping (Any?) -> Void) {
        APIClient.request(endpoint: Endpoint.Auth, parameters: parameters) { json in
            APIClient.token = json["token"].string!
            handler(nil)
        }
    }
    
    static func getMyLists(handler: @escaping ([List]?) -> Void) {
        APIClient.request(endpoint: Endpoint.MyLists) { json in
            let lists: [List]? = (json["lists"].array?.map {
                List(json: $0)
                })
            handler(lists)
        }
    }
}
