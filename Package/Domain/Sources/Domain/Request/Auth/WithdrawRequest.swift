//
//  WithdrawRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

public struct WithdrawRequest {
    public var accessToken: String
}

extension WithdrawRequest: AccessTokenProvider { }
