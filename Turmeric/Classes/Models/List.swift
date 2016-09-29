import Foundation
import SwiftyJSON

class List {
    private let id: Int
    public var name: String

    init (id: Int, name:String) {
        self.id = id
        self.name = name
    }
    
    init (json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}
