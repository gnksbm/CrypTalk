//
//  BackEndError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum BackEndError: Int, Error {
    case missingRequiredValue = 400
    case unauthorized = 401
    case containWhiteSpace = 402
    case forbidden = 403
    case alreadyUsedValue = 409
    case requestFailure = 410
    case accessTokenExpired = 419
    case invalidRefreshToken = 420
    case excessiveRequest = 429
    case invalidURLRequest = 444
    case noPermission = 445
    case serverError = 500
}
