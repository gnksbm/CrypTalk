//
//  UpdateLikeError.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

enum UpdateLikeError: Int, Error {
    case missingRequiredValue = 400
    case invalidToken = 401
    case forbidden = 403
    case canNotFindPost = 410
    case tokenExpired = 419
}
