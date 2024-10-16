//
//  PostResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct PostResponse: Hashable {
    public let postID: String
    public var writter: User
    public let createdAt: Date
    public let content: String
    public let direction: MarketDirection
    public var likerIDs: [String]
    public var comments: [CommentResponse]
    public var isLikedPost = false
    public var imageURLs: [String]
    
    public init(
        postID: String,
        writter: User,
        createdAt: Date,
        content: String,
        direction: MarketDirection,
        likerIDs: [String],
        comments: [CommentResponse],
        imageURLs: [String]
    ) {
        self.postID = postID
        self.writter = writter
        self.createdAt = createdAt
        self.content = content
        self.direction = direction
        self.likerIDs = likerIDs
        self.comments = comments
        self.imageURLs = imageURLs
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
