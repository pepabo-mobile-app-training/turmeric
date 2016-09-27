
import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    static private let baseUrl = "http://currry.xyz"
    
    static func request(endpoint: Endpoint, parameters: Parameters?, handler: @escaping (_ json: JSON) -> Void) {
        let method = endpoint.method()
        let url = fullURL(endpoint: endpoint)
        
        
        Alamofire.request(url, method: method, parameters: parameters).validate(statusCode: 200...299).responseJSON { response in
            switch response.result {
            case .success(let value):
                handler(JSON(value))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func request(endpoint: Endpoint, handler: @escaping (_ json: JSON) -> Void){
        request(endpoint: endpoint, parameters: nil, handler: handler)
    }
    static private func fullURL(endpoint: Endpoint) -> String {
        return baseUrl + endpoint.path()
    }
}

enum Endpoint {
    case Auth
    case UsersFeed
    case UsersCreate
    
    func method() -> HTTPMethod {
        switch self {
        case .Auth: return .post
        case .UsersFeed: return .get
        case .UsersCreate: return .post
        }
    }
    
    func path() -> String {
        switch self {
        case .Auth: return "/api/auth"
        case .UsersFeed: return "/api/feed"
        case .UsersCreate: return "/api/users"
        }
    }
}
