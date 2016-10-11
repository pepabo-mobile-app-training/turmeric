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
    
    static func getList(id: Int, handler: @escaping ((List) -> Void)) {
        APIClient.request(endpoint: Endpoint.ListsShow(id)) { json in
            handler(List(json: json["list"]))
        }
    }
    
    static func getMembers(id:Int, handler: @escaping ([User]) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsMembers(id)) { json in
            let members: [User] = json["members"].array!.map {
                User(json: $0)
                }
            handler(members)
        }
    }
    
    static func update(id: Int, parameters: Parameters, handler: @escaping ((List) -> Void)){
        APIClient.request(endpoint: Endpoint.ListsUpdate(id), parameters: parameters) { json in
            handler(List(json: json["list"]))
        }
    }
    
    static func deleteMember(listId: Int, memberId: Int, handler: @escaping (Void) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsDeleteMember(listId, memberId)) { json in
            handler()
        }
    }
    
    static func addMember(id: Int, parameters: Parameters, handler: @escaping (Void) -> Void) {
        APIClient.request(endpoint: Endpoint.ListsAddMember(id), parameters: parameters) { json in
            handler()
        }
    }
    
    static func getMyLists(handler: @escaping ([List]) -> Void) {
        APIClient.request(endpoint: Endpoint.MyLists) { json in
            let myLists: [List] = json["lists"].array!.map {
                List(json: $0)
            }
            handler(myLists)
        }
    }
}
