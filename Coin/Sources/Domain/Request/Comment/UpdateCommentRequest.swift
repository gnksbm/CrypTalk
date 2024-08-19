//
//  UpdateCommentRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct UpdateCommentRequest {
    let accessToken: String
    let postID: String
    let commentID: String
    let content: String
}

extension UpdateCommentRequest: AccessTokenProvider { }

extension UpdateCommentRequest: BodyProvider {
    var body: Body { Body(content: content) }
    
    struct Body: Encodable {
        let content: String
    }
}
