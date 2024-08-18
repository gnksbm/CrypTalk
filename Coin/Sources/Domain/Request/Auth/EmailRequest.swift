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

extension EmailRequest: ParameterProvider {
    var parameter: Parameter { Parameter(email: email) }
    
    struct Parameter: Encodable {
        let email: String
    }
}
