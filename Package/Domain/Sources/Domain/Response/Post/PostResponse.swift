//
//  PostResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct PostResponse {
    let writter: User
    let content: String
    let direction: MarketDirection
    let likerIDs: [String]
    let comments: [CommentResponse]
    
    public init(
        writter: User,
        content: String,
        direction: MarketDirection,
        likerIDs: [String],
        comments: [CommentResponse]
    ) {
        self.writter = writter
        self.content = content
        self.direction = direction
        self.likerIDs = likerIDs
        self.comments = comments
    }
}
