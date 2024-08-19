//
//  ReadPostWithIDRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadPostWithIDRequest {
    let accessToken: String
    let postID: String
}

extension ReadPostWithIDRequest: AccessTokenProvider { }
