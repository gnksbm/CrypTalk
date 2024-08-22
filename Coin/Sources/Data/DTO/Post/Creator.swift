//
//  Creator.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

struct Creator: Decodable {
    let userID, nick, profileImage: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case nick, profileImage
    }
}

extension Creator {
    func toUser() -> User {
        User(
            id: userID,
            nickname: nick,
            profileImagePath: profileImage
        )
    }
}
