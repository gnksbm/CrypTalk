//
//  ReadLikedPostsRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct ReadLikedPostsRequest {
    public var accessToken: String
}

extension ReadLikedPostsRequest: AccessTokenProvider { }
