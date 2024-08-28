//
//  PostResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct PostResponse {
    public let writter: User
    public let content: String
    public let direction: MarketDirection
    public let likerIDs: [String]
    public let comments: [CommentResponse]
    
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
