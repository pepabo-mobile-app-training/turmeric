import Foundation
import SwiftyJSON

class Micropost {
    let id: Int
    let userId: Int
    let content: String

    init(id: Int, userId: Int, content: String) {
        self.id = id
        self.userId = userId
        self.content = content
    }

    init(json: JSON) {
        self.id = json["micropost"]["id"].int!
        self.userId = json["micropost"]["user_id"].int!
        self.content = json["micropost"]["content"].string!
    }
}
