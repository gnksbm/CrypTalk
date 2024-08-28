//
//  CreatorDTO.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

import Domain

struct CreatorDTO: Decodable {
    let userID, nick: String
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nick, profileImage
    }
}

extension CreatorDTO {
    func toUser() -> User {
        User(
            id: userID,
            nickname: nick,
            profileImagePath: profileImage
        )
    }
}
