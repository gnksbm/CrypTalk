//
//  LoginDTO.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct LoginDTO: Encodable {
    let userID, email, nick: String
    let profileImage: String?
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick, profileImage, accessToken, refreshToken
    }
}
