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

extension DeletePostRequest: HeaderProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}

extension DeletePostRequest: PathProvider {
    var additionalPath: String { "/:\(postID)" }
}
