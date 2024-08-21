//
//  UpdateCommentError.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

enum UpdateCommentError: Int, Error {
    case missingRequiredValue = 400
    case invalidToken = 401
    case forbidden = 403
    case updateFailure = 410
    case tokenExpired = 419
    case noPermissionToEdit = 445
}
