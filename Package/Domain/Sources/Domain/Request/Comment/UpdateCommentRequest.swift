//
//  UpdateCommentRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct UpdateCommentRequest {
    public var accessToken: String
    public let postID: String
    public let commentID: String
    let content: String
}

extension UpdateCommentRequest: AccessTokenProvider { }

extension UpdateCommentRequest: BodyProvider {
    public var body: Body { Body(content: content) }
    
    public struct Body: Encodable {
        let content: String
    }
}
