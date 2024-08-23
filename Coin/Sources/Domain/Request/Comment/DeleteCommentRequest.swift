//
//  DeleteCommentRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct DeleteCommentRequest {
    let accessToken: String
    let postID: String
    let commentID: String
}

extension DeleteCommentRequest: AccessTokenProvider { }
