//
//  CreateCommentError.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

enum CreateCommentError: Int, Error {
    case missingRequiredValue = 400
    case invalidToken = 401
    case forbidden = 403
    case createFailure = 410
    case tokenExpired = 419
}
