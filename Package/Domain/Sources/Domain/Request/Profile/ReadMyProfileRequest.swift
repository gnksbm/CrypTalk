//
//  ReadMyProfileRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct ReadMyProfileRequest {
    public var accessToken: String
}

extension ReadMyProfileRequest: AccessTokenProvider { }
