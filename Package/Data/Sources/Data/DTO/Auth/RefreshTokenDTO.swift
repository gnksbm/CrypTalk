//
//  RefreshTokenDTO.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Domain

struct RefreshTokenDTO: Decodable {
    let message: String
}

extension RefreshTokenDTO {
    func toResponse() -> RefreshTokenResponse {
        RefreshTokenResponse(accessToken: message)
    }
}
