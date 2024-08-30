//
//  CommentResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct CommentResponse: Hashable {
    public let id: String
    public let comment: String
    public let createdAt: Date
    public let writter: User
    
    public init(id: String, comment: String, createdAt: Date, writter: User) {
        self.id = id
        self.comment = comment
        self.createdAt = createdAt
        self.writter = writter
    }
}

extension CommentResponse: Identifiable { }
