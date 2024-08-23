//
//  ReadMyProfileRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadMyProfileRequest {
    let accessToken: String
}

extension ReadMyProfileRequest: AccessTokenProvider { }
