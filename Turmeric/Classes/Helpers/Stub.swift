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
}

func disableHTTPStubs() {
    // "Expression resolves to an unused function"と言われるため
    _ = OHHTTPStubs.removeAllStubs
}

private func stubFilePath(name: String) -> String {
    return OHPathForFileInBundle(name, Bundle.init(identifier: "com.pepabo.training.TurmericTests")!)!
}
