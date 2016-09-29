import Foundation
import SwiftyJSON

class Micropost {
    let id: Int
    let content: String

    init(id: Int, content: String) {
        self.id = id
        self.content = content
    }

    init(json: JSON) {
        self.id = json["micropost"]["id"].int!
        self.content = json["micropost"]["content"].string!
    }
}
