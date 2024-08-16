//
//  RefreshTokenRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct RefreshTokenRequest {
    let refreshToken: String
}

extension RefreshTokenRequest: HeaderProvider {
    var header: Header { Header(refreshToken: refreshToken) }
    
    struct Header: Encodable {
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case refreshToken = "Refresh"
        }
    }
}
