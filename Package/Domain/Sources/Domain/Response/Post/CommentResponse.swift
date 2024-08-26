//
//  CommentResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct CommentResponse {
    let id: String
    let comment: String
    let createdAt: Date
    let writter: User
    
    public init(id: String, comment: String, createdAt: Date, writter: User) {
        self.id = id
        self.comment = comment
        self.createdAt = createdAt
        self.writter = writter
    }
}
