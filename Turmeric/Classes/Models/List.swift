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
}
