//
//  EmailValidationRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct EmailValidationRequest {
    let email: String
}

extension EmailValidationRequest: BodyProvider {
    var body: Body { Body(email: email) }
    
    struct Body: Encodable {
        let email: String
    }
}
