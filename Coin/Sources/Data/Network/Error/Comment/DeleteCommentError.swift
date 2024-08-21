//
//  DeleteCommentError.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

enum DeleteCommentError: Int, Error {
    case missingRequiredValue = 400
    case invalidToken = 401
    case forbidden = 403
    case deleteFailure = 410
    case tokenExpired = 419
    case noPermissionToDelete = 445
}
