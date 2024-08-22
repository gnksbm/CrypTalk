//
//  ReadLikedPostsRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadLikedPostsRequest {
    let accessToken: String
}

extension ReadLikedPostsRequest: AccessTokenProvider { }
