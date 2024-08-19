//
//  UpdateLikeRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct UpdateLikeRequest {
    let accessToken: String
    let postID: String
    let likeStatus: Bool
}

extension UpdateLikeRequest: AccessTokenProvider { }

extension UpdateLikeRequest: BodyProvider {
    var body: Body { Body(likeStatus: likeStatus) }
    
    struct Body: Encodable {
        let likeStatus: Bool
        
        enum CodingKeys: String, CodingKey {
            case likeStatus = "like_status"
        }
    }
}
