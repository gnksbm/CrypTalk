//
//  UpdateLikeResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct UpdateLikeResponse {
    public let likeStatus: Bool
    
    public init(likeStatus: Bool) {
        self.likeStatus = likeStatus
    }
}
