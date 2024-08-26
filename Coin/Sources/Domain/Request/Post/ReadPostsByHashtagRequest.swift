//
//  ReadPostsByHashtagRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadPostsByHashtagRequest {
    var accessToken: String
}

extension ReadPostsByHashtagRequest: AccessTokenProvider { }
