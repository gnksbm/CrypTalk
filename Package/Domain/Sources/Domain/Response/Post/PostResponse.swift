//
//  PostResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct PostResponse: Hashable {
    public let postID: String
    public let writter: User
    public let createdAt: Date
    public let content: String
    public let direction: MarketDirection
    public var likerIDs: [String]
    public let comments: [CommentResponse]
    public var isLikedPost = false
    
    public init(
        postID: String,
        writter: User,
        createdAt: Date,
        content: String,
        direction: MarketDirection,
        likerIDs: [String],
        comments: [CommentResponse]
    ) {
        self.postID = postID
        self.writter = writter
        self.createdAt = createdAt
        self.content = content
        self.direction = direction
        self.likerIDs = likerIDs
        self.comments = comments
    }
}

public extension PostResponse {
    mutating func updateLike(userID: String) {
        isLikedPost = likerIDs.contains(userID)
    }
}

extension PostResponse: Identifiable {
    public var id: String { postID }
}
