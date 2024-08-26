//
//  DeletePostRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct DeletePostRequest {
    public var accessToken: String
    public let postID: String
}

extension DeletePostRequest: AccessTokenProvider { }
