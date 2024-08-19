//
//  ViewPostWithIDRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ViewPostWithIDRequest {
    let accessToken: String
    let postID: String
}

extension ViewPostWithIDRequest: HeaderProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}

extension ViewPostWithIDRequest: PathProvider {
    var additionalPath: String { "/\(postID)" }
}
