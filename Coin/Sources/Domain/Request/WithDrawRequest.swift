//
//  WithDrawRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct WithDrawRequest {
    let accessToken: String
}

extension WithDrawRequest: HeaderProvider {
    var header: Header { Header(accessToken: accessToken) }
    
    struct Header: Encodable {
        let accessToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "Authorization"
        }
    }
}
