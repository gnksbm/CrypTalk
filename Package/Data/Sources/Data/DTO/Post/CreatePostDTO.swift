//
//  CreatePostDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

import Domain

struct CreatePostDTO: Decodable {
    let postID, content: String
    let productID, title: String?
    let content1, content2, content3, content4, content5: String?
    let createdAt: String
    let creator: CreatorDTO
    let files: [String]
    let likes, likes2: [String]
    let hashTags: [String]
    let comments: [CommentDTO]
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productID = "product_id"
        case title, content, content1, content2, content3, content4, content5,
             createdAt, creator, files, likes, likes2, hashTags, comments
    }
}

extension CreatePostDTO {
    func toResponse() throws -> PostResponse {
        let direction = try toMarketDirection()
        let comments = try comments.map { try $0.toResponse() }
        return PostResponse(
            writter: creator.toUser(),
            content: content,
            direction: direction,
            likerIDs: likes,
            comments: comments
        )
    }
    
    func toPortfolio() throws -> PortfolioResponse {
        PortfolioResponse(
            assets: try comments.map { try $0.toAsset() }
        )
    }
    
    func toMarketDirection() throws -> MarketDirection {
        guard let data = content1?.data(using: .utf8) else {
            throw CreatePostDTOError.failureParseContent1
        }
        return try JSONDecoder().decode(MarketDirection.self, from: data)
    }

    enum CreatePostDTOError: Error {
        case failureParseContent1
    }
}

typealias ReadPostWithIDDTO = CreatePostDTO
typealias UpdatePostDTO = CreatePostDTO

