//
//  ReadMyProfileDTO.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

struct ReadMyProfileDTO: Decodable {
    let userID, email, nick, phoneNum: String
    let birthDay, profileImage: String
    let followers, following: [FollowDTO]
    let posts: [String]

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick, phoneNum, birthDay, profileImage, 
             followers, following, posts
    }
}

typealias FollowDTO = CreatorDTO
