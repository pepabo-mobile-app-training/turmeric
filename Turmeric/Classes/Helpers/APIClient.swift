import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    static private let baseUrl = "https://currry.xyz"

    static var token: String?

    static func request(endpoint: Endpoint, parameters: Parameters?, handler: @escaping (_ json: JSON) -> Void) {
        let method = endpoint.method()
        let url = fullURL(endpoint: endpoint)
        let headers = authHeader()

        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate(statusCode: 200...299).responseJSON { response in
            switch response.result {
            case .success(let value):
                handler(JSON(value))
            case .failure(let error):
                print(error)
            }
        }
    }

    static func request(endpoint: Endpoint, handler: @escaping (_ json: JSON) -> Void) {
        request(endpoint: endpoint, parameters: nil, handler: handler)
    }

    static private func fullURL(endpoint: Endpoint) -> String {
        return baseUrl + endpoint.path()
    }

    static private func authHeader() -> HTTPHeaders? {
        if let token = self.token {
            return ["Authorization": "Bearer " + token]
        } else {
            return nil
        }
    }
}

enum Endpoint {
    // User
    case Auth
    case UsersCreate
    case UsersFollowing(Int)
    case UsersFollowers(Int)
    case UsersShow(Int)
    case UsersUpdate(Int)
    case UsersMe
    
    // Micropost
    case MyFeed
    case ListFeed(Int)
    case UsersMicroposts(Int)
    case MicropostsPost
    case MicropostsShow(Int)
    case MicropostsDelete(Int)

    // List
    case MyLists
    case ListsShow(Int)
    case ListsMembers(Int)
    case ListsUpdate(Int)
    case ListsDeleteMember(Int, Int)
    case ListsAddMember(Int)
    case ListsDelete(Int)
    case ListsCreate

    // Relationship
    case RelationshipCreate
    case RelationshipDestroy
    
    func method() -> HTTPMethod {
        switch self {
        case .Auth: return .post
        case .UsersCreate: return .post
        case .UsersFollowing: return .get
        case .UsersFollowers: return .get
        case .UsersShow: return .get
        case .UsersUpdate: return .patch
        case .UsersMe: return .get

        case .MyFeed: return .get
        case .ListFeed: return .get
        case .UsersMicroposts: return .get
        case .MicropostsPost: return .post
        case .MicropostsShow: return .get
        case .MicropostsDelete: return .delete

        case .MyLists: return .get
        case .ListsShow: return .get
        case .ListsMembers: return .get
        case .ListsUpdate: return .patch
        case .ListsDeleteMember: return .delete
        case .ListsAddMember: return .post
        case .ListsDelete: return .delete
        case .ListsCreate: return .post

        case .RelationshipCreate:  return .post
        case .RelationshipDestroy: return .delete
        }
    }

    func path() -> String {
        switch self {
        case .Auth: return "/api/auth"
        case .UsersCreate: return "/api/users"
        case .UsersFollowing(let userId): return "/api/users/\(userId)/following"
        case .UsersFollowers(let userId): return "/api/users/\(userId)/followers"
        case .UsersShow(let userId): return "/api/users/\(userId)"
        case .UsersUpdate(let userId): return "/api/users/\(userId)"
        case .UsersMe: return "/api/users/me"
            
        case .MyFeed: return "/api/feed"
        case .ListFeed(let listId): return "/api/lists/\(listId)/feed"
        case .UsersMicroposts(let userId): return "/api/users/\(userId)/microposts"
        case .MicropostsPost: return "/api/microposts"
        case .MicropostsShow(let micropostId): return "/api/microposts/\(micropostId)"
        case .MicropostsDelete(let micropostId): return "/api/microposts/\(micropostId)"

        case .MyLists: return "/api/lists"
        case .ListsShow(let listId): return "/api/lists/\(listId)"
        case .ListsMembers(let listId): return "/api/lists/\(listId)/members"
        case .ListsUpdate(let listId): return "/api/lists/\(listId)"
        case .ListsDeleteMember(let listId, let memberId): return "/api/lists/\(listId)/members/\(memberId)"
        case .ListsAddMember(let listId): return "/api/lists/\(listId)/members"
        case .ListsDelete(let listId): return "/api/lists/\(listId)"
        case .ListsCreate: return "/api/lists"

        case .RelationshipCreate:  return "/api/relationships"
        case .RelationshipDestroy: return "/api/relationship"
        }
    }
}
