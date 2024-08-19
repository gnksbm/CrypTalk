//
//  ReadProfileRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadProfileRequest {
    let accessToken: String
}

extension ReadProfileRequest: AccessTokenProvider { }
