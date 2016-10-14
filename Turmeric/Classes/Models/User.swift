import Foundation
import Alamofire
import SwiftyJSON
import KeychainAccess

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
    
    static func createUser(parameters: Parameters, handler: @escaping ((APIResponse<User>) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { response in
            switch response {
            case .Success(let json):
                handler(APIResponse.Success(User(json: json["user"])))
            default:
                let error = response.error(type: User.self)
                handler(error)
            }
        }
    }


    static func getMyUser(handler: @escaping ((APIResponse<User>) -> Void)) {

        APIClient.request(endpoint: Endpoint.UsersMe, parameters: [:]) { response in
            switch response {
            case .Success(let json):
                handler(APIResponse.Success(User(json: json["user"])))
            default:
                let error = response.error(type: User.self)
                handler(error)
            }

        }
    }
    
    static func getUser(userID: Int, handler: @escaping ((APIResponse<User>) -> Void)){
        APIClient.request(endpoint: Endpoint.UsersShow(userID)) { response in
            switch response {
            case .Success(let json):
                handler(APIResponse.Success(User(json: json["user"])))
            default:
                let error = response.error(type: User.self)
                handler(error)
            }
        }
    }

    static func authenticate(parameters: Parameters, handler: @escaping (APIResponse<Any?>) -> Void) {
        APIClient.request(endpoint: Endpoint.Auth, parameters: parameters) { response in
            switch response {
            case .Success(let json):
                saveToken(json["token"].string!)
                handler(APIResponse.Success(nil))
            default:
                let error = response.error(type: (Any?.self)!)
                handler(error)
            }
        }
    }

    static func getMyFeed(handler: @escaping (APIResponse<[Micropost]?>) -> Void) {
        APIClient.request(endpoint: Endpoint.MyFeed) { response in
            switch response {
            case .Success(let json):
                let microposts: [Micropost]? = (json["feed"].array?.map {
                    Micropost(json: $0)
                    })
                handler(APIResponse.Success(microposts))
            default:
                let error = response.error(type: ([Micropost]?.self)!)
                handler(error)
            }
        }
    }

    static func getMyLists(handler: @escaping (APIResponse<[List]?>) -> Void) {
        APIClient.request(endpoint: Endpoint.MyLists) { response in
            switch response {
            case .Success(let json):
                let lists: [List]? = (json["lists"].array?.map {
                    List(json: $0)
                    })
                handler(APIResponse.Success(lists))
            default:
                let error = response.error(type: ([List]?.self)!)
                handler(error)
            }
        }
    }

    static func getFollowing(id: Int, handler: @escaping ((APIResponse<[User]?>) -> Void) ) {
        APIClient.request(endpoint: Endpoint.UsersFollowing(id)) { response in
            switch response {
            case .Success(let json):
                let users: [User]? = (json["following"]["users"].array?.map { User(json: $0) })
                handler(APIResponse.Success(users))
            default:
                let error = response.error(type: ([User]?.self)!)
                handler(error)
            }
        }
    }

    static func getFollowers(id: Int, handler: @escaping ((APIResponse<[User]?>) -> Void) ) {
        APIClient.request(endpoint: Endpoint.UsersFollowers(id)) { response in
            switch response {
            case .Success(let json):
                let users: [User]? = (json["followers"]["users"].array?.map { User(json: $0) })
                handler(APIResponse.Success(users))
            default:
                let error = response.error(type: ([User]?.self)!)
                handler(error)
            }
        }
    }

    static func logout() {
        APIClient.token = nil
        let keychain = Keychain(service: "com.pepabo.training.Turmeric")
        do {
            try keychain.remove("token")
        }
        catch let error {
            // TODO: エラー処理する
            print("Error: can't remove token")
            print(error)
        }
    }

    private static func saveToken(_ token: String) {
        APIClient.token = token
        // Keychainにトークンを保存する
        let keychain = Keychain(service: "com.pepabo.training.Turmeric")
        do {
            try keychain.set(token, key: "token")
        }
        catch let error {
            // TODO: エラー処理する
            print("Error: can't save token")
            print(error)
        }
    }

    static func loadToken() {
        // Keychainからトークンを読み出す
        let keychain = Keychain(service: "com.pepabo.training.Turmeric")
        if let token = keychain["token"] {
            APIClient.token = token
        }
    }
}
