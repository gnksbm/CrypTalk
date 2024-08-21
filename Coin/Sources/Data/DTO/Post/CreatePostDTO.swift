//
//  CreatePostDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

struct CreatePostDTO: Decodable {
    let postID, productID, title, content: String
    let content1, content2, content3, content4: String
    let content5, createdAt: String
    let creator: Creator
    let files: [String]
    let likes, likes2: [String]
    let hashTags: [String]
    let comments: [String]

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case productID = "product_id"
        case title, content, content1, content2, content3, content4, content5,
             createdAt, creator, files, likes, likes2, hashTags, comments
    }
}

typealias ReadPostWithIDDTO = CreatePostDTO
typealias UpdatePostDTO = CreatePostDTO

