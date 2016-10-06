import Foundation
import Alamofire
import SwiftyJSON

class User {

    let id: Int
    let name: String
    let email: String?
    let iconURL: String
    let followingCount: Int?
    let followersCount: Int?
    let micropostsCount: Int?

    init(id: Int, name: String, iconURL: String, email: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.iconURL = iconURL
        
        self.followersCount  = nil
        self.followingCount  = nil
        self.micropostsCount = nil
    }

    init(json: JSON) {
        self.id = json["id"].int!
        self.name = json["name"].string!
        self.email = json["email"].string

        self.followingCount  = json["following_count"].int
        self.followersCount  = json["followers_count"].int
        self.micropostsCount = json["microposts_count"].int
        self.iconURL = json["icon_url"].string!
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

    static func getMyFeed(handler: @escaping ([Micropost]?) -> Void) {
        APIClient.request(endpoint: Endpoint.MyFeed) { json in
            let microposts: [Micropost]? = (json["feed"].array?.map {
                Micropost(json: $0)
                })
            handler(microposts)
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
    
    static func getFollowing(id: Int, handler: @escaping (([User]?) -> Void) ) {
        APIClient.request(endpoint: Endpoint.UsersFollowing(id)) { json in
            let users: [User]? = (json["following"]["users"].array?.map { User(json: $0) })
            handler(users)
        }

    }
}
