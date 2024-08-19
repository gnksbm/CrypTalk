//
//  RefreshTokenRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct RefreshTokenRequest {
    let accessToken: String
    let refreshToken: String
}

extension RefreshTokenRequest: HeaderProvider {
    var header: Header {
        Header(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
    
    struct Header: Encodable {
        let accessToken: String
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "Authorization"
            case refreshToken = "Refresh"
        }
    }
}
