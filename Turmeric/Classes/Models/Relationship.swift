import Foundation
import Alamofire
import SwiftyJSON

class Relationship {
    static func createRelationship(userID: Int, handler: @escaping (() -> Void)) {
        let parameters: [String: Any] = [
            "relationship": [
                "followed_id": userID
            ]
        ]
        
        APIClient.request(endpoint: Endpoint.RelationshipCreate, parameters: parameters) { json in
            handler()
        }
    }
    
    static func destroyRelationship(userID: Int, handler: @escaping (() -> Void)) {
        let parameters: [String: Any] = [
            "relationship": [
                "followed_id": userID
            ]
        ]
        
        APIClient.request(endpoint: Endpoint.RelationshipDestroy, parameters: parameters) { json in
            handler()
        }
    }
}
