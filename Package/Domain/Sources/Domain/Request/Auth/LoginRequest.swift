//
//  LoginRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

public struct LoginRequest {
    let email: String
    let password: String
}

extension LoginRequest: BodyProvider {
    public var body: Body {
        Body(email: email, password: password)
    }
    
    public struct Body: Encodable {
        let email: String
        let password: String
    }
}
