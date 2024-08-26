//
//  UpdateLikeDTO.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import Domain

struct UpdateLikeDTO: Decodable {
    let likeStatus: Bool

    enum CodingKeys: String, CodingKey {
        case likeStatus = "like_status"
    }
}

extension UpdateLikeDTO {
    func toResponse() -> UpdateLikeResponse {
        UpdateLikeResponse(likeStatus: likeStatus)
    }
}
