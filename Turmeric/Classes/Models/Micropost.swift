import Foundation
import SwiftyJSON

class Micropost {
    let id: Int
    let userId: Int
    let content: String
    let picture: NSURL?

    init(id: Int, userId: Int, content: String, picture: NSURL?) {
        self.id = id
        self.userId = userId
        self.content = content
        self.picture = picture
    }

    init(json: JSON) {
        self.id = json["micropost"]["id"].int!
        self.userId = json["micropost"]["user_id"].int!
        self.content = json["micropost"]["content"].string!
        if let picture = json["micropost"]["picture"].string {
            self.picture = NSURL(string: picture)
        } else {
            self.picture = nil
        }
    }
}
