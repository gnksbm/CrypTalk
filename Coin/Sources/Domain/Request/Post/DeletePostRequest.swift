//
//  DeletePostRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct DeletePostRequest {
    var accessToken: String
    let postID: String
}

extension DeletePostRequest: AccessTokenProvider { }
