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
    case UsersMicropost
    case UsersFollowing
    case UsersFollowers
    case UsersShow
    case UsersUpdate
    
    //Microposts
    case MicropostsPost
    case MicropostsShow
    case MicropostsDelete
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
    
    func path(id: Int?) -> String {
        switch self {
        case .Auth: return "/api/auth"
        case .UsersFeed: return "/api/feed"
        case .UsersCreate: return "/api/users"
        case .UsersMicropost: return "/api/users/\(id)/microposts"
        case .UsersFollowing: return "/api/users/\(id)/following"
        case .UsersFollowers: return "/api/users/\(id)/followers"
        case .UsersShow: return "/api/users/\(id)"
        case .UsersUpdate: return "/api/users/\(id)"
            
        case .MicropostsPost: return "/api/microposts"
        case .MicropostsShow: return "/api/microposts/\(id)"
        case .MicropostsDelete: return "/api/microposts/\(id)"
        case .Feed: return "api/feed"
        }
    }
    
    func path() -> String {
        return path(id: nil)
    }
}
