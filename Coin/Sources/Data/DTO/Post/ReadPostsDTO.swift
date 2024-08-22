//
//  ReadPostsDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

typealias Post = CreatePostDTO

struct ReadPostsDTO: Decodable {
    let data: [Post]
}

extension ReadPostsDTO {
    func toResponse() throws -> [PostResponse] {
        try data.map { try $0.toResponse() }
    }
}

typealias ReadPostsByUserDTO = ReadPostsDTO
typealias ReadPostsByHashtagDTO = ReadPostsDTO
typealias ReadLikedPostsDTO = ReadPostsDTO

