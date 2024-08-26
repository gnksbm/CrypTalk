//
//  EmailValidationRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

public struct EmailValidationRequest {
    let email: String
}

extension EmailValidationRequest: BodyProvider {
    public var body: Body { Body(email: email) }
    
    public struct Body: Encodable {
        let email: String
    }
}
