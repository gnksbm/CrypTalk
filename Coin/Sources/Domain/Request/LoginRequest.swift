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

extension LoginRequest: ParameterProvider {
    var parameter: Parameter {
        Parameter(email: email, password: password)
    }
    
    struct Parameter: Encodable {
        let email: String
        let password: String
    }
}
