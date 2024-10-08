//
//  JoinRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

public struct JoinRequest {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String?
    let birthDay: String?
}

extension JoinRequest: BodyProvider {
    public var body: Body {
        Body(
            email: email,
            password: password,
            nick: nick,
            phoneNum: phoneNum,
            birthDay: birthDay
        )
    }
    
    public struct Body: Encodable {
        let email: String
        let password: String
        let nick: String
        let phoneNum: String?
        let birthDay: String?
    }
}
