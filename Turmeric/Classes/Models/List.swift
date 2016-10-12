import Foundation
import SwiftyJSON
import Alamofire

class List {
    let id: Int
    let name: String
    
    init (id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init (json: JSON) {
        self.id = json["id"].int!
        self.name = json["name"].string!
    }
    
    static func getList(id: Int, handler: @escaping ((APIResponse<List>) -> Void)) {
        APIClient.request(endpoint: Endpoint.ListsShow(id)) { response in
            switch response {
            case .Success(let json):
                handler(APIResponse.Success(List(json: json["list"])))
            default: break
            }
            
        }
    }
    
    static func getMembers(id:Int, handler: @escaping (APIResponse<[User]>) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsMembers(id)) { response in
            switch response {
            case .Success(let json):
                let members: [User] = json["members"].array!.map {
                    User(json: $0)
                }
                handler(APIResponse.Success(members))
            default: break
            }
            
        }
    }
    
    static func update(id: Int, parameters: Parameters, handler: @escaping ((APIResponse<List>) -> Void)){
        APIClient.request(endpoint: Endpoint.ListsUpdate(id), parameters: parameters) { response in
            switch response {
            case .Success(let json):
                handler(APIResponse.Success(List(json: json["list"])))
            default: break
            }
            
        }
    }
    
    static func deleteMember(listId: Int, memberId: Int, handler: @escaping (APIResponse<Any?>) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsDeleteMember(listId, memberId)) { response in
            switch response {
            case .Success:
                handler(APIResponse.Success(nil))
            default: break
            }
            
        }
    }
    
    static func addMember(id: Int, parameters: Parameters, handler: @escaping (APIResponse<Any?>) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsAddMember(id), parameters: parameters) { response in
            switch response {
            case .Success:
                handler(APIResponse.Success(nil))
            default: break
            }
        }
    }
    
    static func deleteList(id: Int, handler: @escaping (APIResponse<Any?>) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsDelete(id)) { response in
            switch response {
            case .Success:
                handler(APIResponse.Success(nil))
            default: break
            }
        }
    }
    
    static func createList(parameters: Parameters, handler: @escaping ((APIResponse<List>) -> Void)){
        APIClient.request(endpoint: Endpoint.ListsCreate, parameters: parameters) { response in
            switch response {
            case .Success(let json):
                handler(APIResponse.Success(List(json: json["list"])))
            default: break
            }
        }
    }
}
