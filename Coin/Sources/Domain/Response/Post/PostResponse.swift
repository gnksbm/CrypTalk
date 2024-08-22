//
//  PostResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

struct PostResponse {
    let writter: User
    let content: String
    let direction: MarketDirection
    let likerIDs: [String]
    let comments: [CommentResponse]
}
