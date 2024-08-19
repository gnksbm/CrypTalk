//
//  EmailRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct EmailRequest {
    let email: String
}

extension EmailRequest: BodyProvider {
    var body: Body { Body(email: email) }
    
    struct Body: Encodable {
        let email: String
    }
}
