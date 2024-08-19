//
//  LoginRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct LoginRequest {
    let email: String
    let password: String
}

extension LoginRequest: BodyProvider {
    var body: Body {
        Body(email: email, password: password)
    }
    
    struct Body: Encodable {
        let email: String
        let password: String
    }
}
