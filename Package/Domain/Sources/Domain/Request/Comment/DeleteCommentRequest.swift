//
//  DeleteCommentRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct DeleteCommentRequest {
    public var accessToken: String
    public let postID: String
    public let commentID: String
}

extension DeleteCommentRequest: AccessTokenProvider { }
