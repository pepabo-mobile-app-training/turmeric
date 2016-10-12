import Foundation
import Alamofire
import SwiftyJSON

class Micropost {
    let id: Int
    let userId: Int
    let content: String
    let picture: URL?
    let user: User

    init(id: Int, userId: Int, content: String, picture: URL?, user: User) {
        self.id = id
        self.userId = userId
        self.content = content
        self.picture = picture
        self.user = user
    }

    init(json: JSON) {
        self.id = json["id"].int!
        self.userId = json["user_id"].int!
        self.content = json["content"].string!
        if let picture = json["picture"].string {
            self.picture = URL(string: picture)
        } else {
            self.picture = nil
        }
        self.user = User(json: json["user"])
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

    static func getFeed(endpoint: Endpoint, handler: @escaping ([Micropost]?) -> Void) {
        APIClient.request(endpoint: endpoint) { json in
            let microposts: [Micropost]?

            switch endpoint {
            case .UsersMicroposts:
                microposts = (json["microposts"].array?.map { Micropost(json: $0) })
            default:
                microposts = (json["feed"].array?.map { Micropost(json: $0) })
            }
            handler(microposts)
        }
    }
}
