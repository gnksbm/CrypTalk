//
//  LoginResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct LoginResponse {
    let userID, accessToken, refreshToken: String
    
    public init(
        userID: String,
        accessToken: String,
        refreshToken: String
    ) {
        self.userID = userID
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
