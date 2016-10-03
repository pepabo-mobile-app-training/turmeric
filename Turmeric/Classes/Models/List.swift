import Foundation
import SwiftyJSON

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
        APIClient.request(endpoint: Endpoint.ListShow(id)) { json in
            handler(List(json: json["list"]))
        }
    }
    
    static func getMembers(id:Int, handler: @escaping ([User]?) -> Void) {
        APIClient.request(endpoint: Endpoint.ListMembers(id)) { json in
            let members: [User]? = (json["members"].array?.map {
                User(json: $0)
                })
            handler(members)
        }
    }
}
