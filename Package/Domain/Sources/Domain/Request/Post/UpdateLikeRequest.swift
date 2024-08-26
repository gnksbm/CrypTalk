//
//  UpdateLikeRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct UpdateLikeRequest {
    public var accessToken: String
    public let postID: String
    let likeStatus: Bool
}

extension UpdateLikeRequest: AccessTokenProvider { }

extension UpdateLikeRequest: BodyProvider {
    public var body: Body { Body(likeStatus: likeStatus) }
    
    public struct Body: Encodable {
        let likeStatus: Bool
        
        enum CodingKeys: String, CodingKey {
            case likeStatus = "like_status"
        }
    }
}
