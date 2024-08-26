//
//  CreateCommentRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct CreateCommentRequest {
    public var accessToken: String
    public let postID: String
    let content: String
}

extension CreateCommentRequest: AccessTokenProvider { }

extension CreateCommentRequest: BodyProvider {
    public var body: Body { Body(content: content) }
    
    public struct Body: Encodable {
        let content: String
    }
}
