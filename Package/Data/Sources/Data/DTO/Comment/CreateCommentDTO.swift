//
//  CreateCommentDTO.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import Domain

struct CreateCommentDTO: Decodable {
    let commentID, content, createdAt: String
    let creator: CreatorDTO

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case content, createdAt, creator
    }
}

extension CreateCommentDTO {
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
    
    func toAsset() throws -> CryptoAsset {
        guard let data = content.data(using: .utf8) else {
            throw CommentDTOError.failureParseCryptoAsset
        }
        return try JSONDecoder().decode(CryptoAsset.self, from: data)
    }
    
    enum CommentDTOError: Error {
        case failureParseCreatedAt, failureParseCryptoAsset
    }
}

typealias UpdateCommentDTO = CreateCommentDTO
typealias DeleteCommentDTO = EmptyResponse
