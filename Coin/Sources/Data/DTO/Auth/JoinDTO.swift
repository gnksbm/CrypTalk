//
//  JoinDTO.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct JoinDTO: Decodable {
    let userID, email, nick: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick
    }
}

extension JoinDTO {
    func toResponse() -> JoinResponse {
        JoinResponse(userID: userID, email: email)
    }
}
