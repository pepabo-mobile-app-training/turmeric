
import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    static private let baseUrl = "http://currry.xyz"
    
    static func request(endpoint: Endpoint, handler: @escaping (_ json: JSON) -> Void) {
        let method = endpoint.method()
        let url = fullURL(endpoint: endpoint)
        
        Alamofire.request(url, method: method).validate(statusCode: 200...299).responseJSON { response in
            switch response.result {
            case .success(let value):
                handler(JSON(value))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static private func fullURL(endpoint: Endpoint) -> String {
        return baseUrl + endpoint.path()
    }
}

enum Endpoint {
    case Auth
    case UsersFeed
    
    func method() -> HTTPMethod {
        switch self {
        case .Auth: return .post
        case .UsersFeed: return .get
        }
    }
    
    func path() -> String {
        switch self {
        case .Auth: return "/api/auth"
        case .UsersFeed: return "/api/feed"
        }
    }
}
