//
//  CreateCommentRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct CreateCommentRequest {
    let accessToken: String
    let postID: String
    let content: String
}

extension CreateCommentRequest: HeaderProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}

extension CreateCommentRequest: BodyProvider {
    var body: Body { Body(content: content) }
    
    struct Body: Encodable {
        let content: String
    }
}
