//
//  UpdateProfileRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya

struct UpdateProfileRequest {
    let accessToken: String
    let nick: String?
    let phoneNum: String?
    let birthDay: String?
    let profile: Data?
}

extension UpdateProfileRequest: AccessTokenProvider { }

extension UpdateProfileRequest: BodyProvider {
    var body: Body {
        Body(
            nick: nick,
            phoneNum: phoneNum,
            birthDay: birthDay,
            profile: profile
        )
    }
    
    struct Body: Encodable {
        let nick: String?
        let phoneNum: String?
        let birthDay: String?
        let profile: Data?
    }
}
