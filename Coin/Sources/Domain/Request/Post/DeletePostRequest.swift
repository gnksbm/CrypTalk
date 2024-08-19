//
//  DeletePostRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct DeletePostRequest {
    let accessToken: String
    let postID: String
}

extension DeletePostRequest: AccessTokenProvider { }
