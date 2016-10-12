import Foundation
import Alamofire
import SwiftyJSON

class User {

    let id: Int
    let name: String
    let email: String?
    let iconURL: URL
    let followingCount: Int?
    let followersCount: Int?
    let micropostsCount: Int?
    
    init(id: Int, name: String, iconURL: URL, email: String? = nil) {
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
        self.iconURL = URL(string: json["icon_url"].string!)!
    }
    
    static func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { response in
            switch response {
            case .Success(let json):
                handler(User(json: json["user"]))
            default:
                break
            }
        }
    }

    static func getMyUser(handler: @escaping ((User) -> Void)) {

        APIClient.request(endpoint: Endpoint.UsersMe, parameters: [:]) { response in
            switch response {
            case .Success(let json):
                handler(User(json: json["user"]))
            default:
                break
            }

        }
    }
    
    static func getUser(userID: Int, handler: @escaping ((User) -> Void)){
        APIClient.request(endpoint: Endpoint.UsersShow(userID)) { response in
            switch response {
            case .Success(let user):
                handler(User(json: json["user"]))
            default: break
            }
        }
    }

    static func authenticate(parameters: Parameters, handler: @escaping (Any?) -> Void) {
        APIClient.request(endpoint: Endpoint.Auth, parameters: parameters) { response in
            switch response {
            case .Success(let json):
                APIClient.token = json["token"].string!
                handler(nil)
            default:
                break
            }
        }
    }

    static func getMyFeed(handler: @escaping ([Micropost]?) -> Void) {
        APIClient.request(endpoint: Endpoint.MyFeed) { response in
            switch response {
            case .Success(let json):
                let microposts: [Micropost]? = (json["feed"].array?.map {
                    Micropost(json: $0)
                    })
                handler(microposts)
            default: break
            }
        }
    }

    static func getMyLists(handler: @escaping ([List]?) -> Void) {
        APIClient.request(endpoint: Endpoint.MyLists) { response in
            switch response {
            case .Success(let json):
                let lists: [List]? = (json["lists"].array?.map {
                    List(json: $0)
                    })
                handler(lists)
            default:
                break
            }
        }
    }

    static func getFollowing(id: Int, handler: @escaping (([User]?) -> Void) ) {
        APIClient.request(endpoint: Endpoint.UsersFollowing(id)) { response in
            switch response {
            case .Success(let json):
                let users: [User]? = (json["following"]["users"].array?.map { User(json: $0) })
                handler(users)
            default: break
            }
        }
    }

    static func getFollowers(id: Int, handler: @escaping (([User]?) -> Void) ) {
        APIClient.request(endpoint: Endpoint.UsersFollowers(id)) { response in
            switch response {
            case .Success(let json):
                let users: [User]? = (json["followers"]["users"].array?.map { User(json: $0) })
                handler(users)
            default: break
            }
        }
    }
}
