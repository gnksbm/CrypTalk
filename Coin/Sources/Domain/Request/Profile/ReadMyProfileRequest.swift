//
//  ReadMyProfileRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadMyProfileRequest {
    var accessToken: String
}

extension ReadMyProfileRequest: AccessTokenProvider { }
