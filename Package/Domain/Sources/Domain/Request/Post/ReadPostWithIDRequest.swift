//
//  ReadPostWithIDRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct ReadPostWithIDRequest {
    public var accessToken: String
    public let postID: String
    
    public init(
        accessToken: String,
        postID: String
    ) {
        self.accessToken = accessToken
        self.postID = postID
    }
}

extension ReadPostWithIDRequest: AccessTokenProvider { }
