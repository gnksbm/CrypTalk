//
//  RefreshTokenResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct RefreshTokenResponse {
    let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
