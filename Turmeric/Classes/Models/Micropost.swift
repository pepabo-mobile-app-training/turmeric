import Foundation
import Alamofire
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
        self.id = json["id"].int!
        self.userId = json["user_id"].int!
        self.content = json["content"].string!
        if let picture = json["picture"].string {
            self.picture = NSURL(string: picture)
        } else {
            self.picture = nil
        }
    }
    
    static func postMicropost(parameters: Parameters, handler: @escaping ((Micropost) -> Void)) {
        APIClient.request(endpoint: Endpoint.MicropostsPost, parameters: parameters) { json in
            handler(Micropost(json: json["micropost"]))
        }
    }

    static func getMicropost(id: Int, handler: @escaping ((Micropost) -> Void)) {
        APIClient.request(endpoint: Endpoint.MicropostsShow(id)) { json in
            handler(Micropost(json: json["micropost"]))
        }
    }
}
