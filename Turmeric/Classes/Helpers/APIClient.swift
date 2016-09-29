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
    case Auth
    case UsersFeed
    case UsersCreate
    case UsersMicropost(Int)
    case UsersFollowing(Int)
    case UsersFollowers(Int)
    case UsersShow(Int)
    case UsersUpdate(Int)
    
    //Microposts
    case MicropostsPost
    case MicropostsShow(Int)
    case MicropostsDelete(Int)
    case Feed
    
    
    func method() -> HTTPMethod {
        switch self {
        case .Auth: return .post
        case .UsersFeed: return .get
        case .UsersCreate: return .post
        case .UsersMicropost: return .get
        case .UsersFollowing: return .get
        case .UsersFollowers: return .get
        case .UsersShow: return .get
        case .UsersUpdate: return .patch
            
        case .MicropostsPost: return .post
        case .MicropostsShow: return .get
        case .MicropostsDelete: return .delete
        case .Feed: return .get
        }
    }
    
    func path() -> String {
        switch self {
        case .Auth: return "/api/auth"
        case .UsersFeed: return "/api/feed"
        case .UsersCreate: return "/api/users"
        case .UsersMicropost(let userId): return "/api/users/\(userId)/microposts"
        case .UsersFollowing(let userId): return "/api/users/\(userId)/following"
        case .UsersFollowers(let userId): return "/api/users/\(userId)/followers"
        case .UsersShow(let userId): return "/api/users/\(userId)"
        case .UsersUpdate(let userId): return "/api/users/\(userId)"
            
        case .MicropostsPost: return "/api/microposts"
        case .MicropostsShow(let micropostId): return "/api/microposts/\(micropostId)"
        case .MicropostsDelete(let micropostId): return "/api/microposts/\(micropostId)"
        case .Feed: return "api/feed"
        }
    }
}
