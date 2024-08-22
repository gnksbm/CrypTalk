//
//  CommentDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

struct CommentDTO: Decodable {
    let commentID, content, createdAt: String
    let creator: CreatorDTO

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case content, createdAt, creator
    }
}

extension CommentDTO {
    func toResponse() throws -> CommentResponse {
        guard let date = createdAt.iso8601Formatted() else {
            throw CommentDTOError.failureParseCreatedAt
        }
        return CommentResponse(
            id: commentID,
            comment: content,
            createdAt: date,
            writter: creator.toUser()
        )
    }
    
    enum CommentDTOError: Error {
        case failureParseCreatedAt
    }
}
