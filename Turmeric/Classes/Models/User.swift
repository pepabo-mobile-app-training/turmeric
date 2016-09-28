//
//  User.swift
//  Turmeric
//
//  Created by usr0600438 on 2016/09/27.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class User {
    
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    class func createUser(parameters: Parameters, handler: @escaping ((User) -> Void)) {
        APIClient.request(endpoint: Endpoint.UsersCreate, parameters: parameters) { json in
            handler(User(id: json["user"]["id"].intValue, name: json["user"]["name"].stringValue))
        }
    }
}
