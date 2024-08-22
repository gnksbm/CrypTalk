//
//  WithdrawRequest.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

struct WithdrawRequest {
    let accessToken: String
}

extension WithdrawRequest: AccessTokenProvider { }
