//
//  ReadLikedPosts.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadLikedPosts {
    let accessToken: String
}

extension ReadLikedPosts: HeaderProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}
