import Foundation
import Alamofire
import SwiftyJSON

class Relationship {
    static func createRelationship(userID: Int, handler: @escaping ((APIResponse<Any?>) -> Void)) {
        let parameters: [String: Any] = [
            "relationship": [
                "followed_id": userID
            ]
        ]
        
        APIClient.request(endpoint: Endpoint.RelationshipCreate, parameters: parameters) { response in
            switch response {
            case .Success:
                handler(APIResponse.Success(nil))
            default: break
            }
        }
    }
    
    static func destroyRelationship(userID: Int, handler: @escaping ((APIResponse<Any?>) -> Void)) {
        let parameters: [String: Any] = [
            "relationship": [
                "followed_id": userID
            ]
        ]
        
        APIClient.request(endpoint: Endpoint.RelationshipDestroy, parameters: parameters) { response in
            switch response {
            case .Success:
                handler(APIResponse.Success(nil))
            default: break
            }
            
        }
    }
}
