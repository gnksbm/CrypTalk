//
//  RefreshTokenRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

public struct RefreshTokenRequest {
    public let accessToken: String
    let refreshToken: String
}

extension RefreshTokenRequest: HeaderProvider {
    public var header: Header {
        Header(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
    
    public struct Header: Encodable {
        let accessToken: String
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "Authorization"
            case refreshToken = "Refresh"
        }
    }
}
