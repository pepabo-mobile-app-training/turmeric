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
        self.id = json["id"].int!
        self.name = json["name"].string!
        self.email = json["email"].string!
        
        self.followingCount  = json["following_count"].int
        self.followersCount  = json["followers_count"].int
        self.micropostsCount = json["microposts_count"].int
        
        if let iconUrl = json["icon_url"].string {
            self.iconUrl = NSURL(string: iconUrl)
        }
    }

    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(json: json["user"]))
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
    
    static func getMyLists(handler: @escaping ([List]?) -> Void) {
        APIClient.request(endpoint: Endpoint.MyLists) { json in
            let lists: [List]? = (json["lists"].array?.map {
                List(json: $0)
                })
            handler(lists)
        }
    }
}
