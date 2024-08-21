//
//  Comment.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

struct Comment: Decodable {
    let commentID, content, createdAt: String
    let creator: Creator

    enum CodingKeys: String, CodingKey {
        case commentID = "comment_id"
        case content, createdAt, creator
    }
}
