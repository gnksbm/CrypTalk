//
//  DeletePostError.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

enum DeletePostError: Int, Error {
    case invalidToken = 401
    case forbidden = 403
    case canNotFindPost = 410
    case tokenExpired = 419
    case noPermissionToDelete = 445
}
