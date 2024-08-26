//
//  WithdrawRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct WithdrawRequest {
    var accessToken: String
}

extension WithdrawRequest: AccessTokenProvider { }
