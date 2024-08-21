//
//  ReadPostDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

typealias Post = CreatePostDTO

struct ReadPostDTO: Decodable {
    let data: [Post]
}
