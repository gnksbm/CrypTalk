//
//  ReadPostsByHashtagRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct ReadPostsByHashtagRequest {
    public var accessToken: String
}

extension ReadPostsByHashtagRequest: AccessTokenProvider { }
