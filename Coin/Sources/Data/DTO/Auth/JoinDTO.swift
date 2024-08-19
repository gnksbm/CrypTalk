//
//  JoinDTO.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct JoinDTO: Encodable {
    let userID, email, nick: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick
    }
}
