//
//  WithdrawDTO.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Domain

struct WithdrawDTO: Decodable {
    let userID, email, nick: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick
    }
}

extension WithdrawDTO {
    func toResponse() -> EmptyResponse {
        EmptyResponse()
    }
}
