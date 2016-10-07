//
//  Stub.swift
//  Turmeric
//
//  Created by usr0600437 on 2016/10/03.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import Foundation
import OHHTTPStubs

func enableHTTPStubs() {
    // Micropost
    stub(condition: isHost("currry.xyz") && isPath("/api/feed") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MyFeed.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/microposts/100") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MicropostsShow.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/microposts/101") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MicropostsShow_withPicture.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/microposts") && isMethodPOST()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MicropostsPost.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }


    // User
    stub(condition: isHost("currry.xyz") && isPath("/api/users") && isMethodPOST()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "UsersCreate.json"),
            statusCode: 201,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/auth") && isMethodPOST()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "Auth.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/users/1/following") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "UsersFollowing.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/users/1/followers") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "UsersFollowers.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }

    // List
    stub(condition: isHost("currry.xyz") && isPath("/api/lists") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "MyLists.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/users/me") && isMethodGET()){_ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "Me.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    
    //List
    stub(condition: isHost("currry.xyz") && isPath("/api/lists/1") && isMethodGET()){ _ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "ListsShow.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/lists/1/members") && isMethodGET()){ _ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "ListsMembers.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    
    stub(condition: isHost("currry.xyz") && isPath("/api/lists/1") && isMethodPATCH()) { _ in
        return OHHTTPStubsResponse(
            fileAtPath: stubFilePath(name: "ListsUpdate.json"),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )
    }
    
    stub(condition: isHost("currry.xyz") && isPath("/api/lists/1/members/101") && isMethodDELETE()) { _ in
        return OHHTTPStubsResponse(jsonObject : [], statusCode: 200, headers: nil)
    }
    
    //Relationship
    stub(condition: isHost("currry.xyz") && isPath("/api/relationship") && isMethodDELETE()) { _ in
        return OHHTTPStubsResponse(jsonObject : [], statusCode: 200, headers: nil)
    }
    stub(condition: isHost("currry.xyz") && isPath("/api/relationship") && isMethodPOST()) { _ in
        return OHHTTPStubsResponse(jsonObject : [], statusCode: 200, headers: nil)
    }
}

func disableHTTPStubs() {
    // "Expression resolves to an unused function"と言われるため
    _ = OHHTTPStubs.removeAllStubs
}

private func stubFilePath(name: String) -> String {
    return OHPathForFileInBundle(name, Bundle.main)!
}
