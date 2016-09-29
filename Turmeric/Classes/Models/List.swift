import Foundation
import SwiftyJSON

class List {
    let id: Int
    var name: String

    init (id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init (json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}
