//
//  ReadPostsDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

import Domain

typealias Post = CreatePostDTO

struct ReadPostsDTO: Decodable {
    let data: [Post]
}

extension ReadPostsDTO {
    func toResponse() throws -> [PostResponse] {
        try data.map { try $0.toResponse() }
    }
    
    func toPortfolio() throws -> PortfolioResponse {
        guard let response = data.first else {
            throw PortfolioError.canNotFindPortfolio
        }
        return PortfolioResponse(
            assets: try response.comments.map { try $0.toAsset() }
        )
    }
}

typealias ReadPostsByUserDTO = ReadPostsDTO
typealias ReadPostsByHashtagDTO = ReadPostsDTO
typealias ReadLikedPostsDTO = ReadPostsDTO

