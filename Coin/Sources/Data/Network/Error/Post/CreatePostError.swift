//
//  CreatePostError.swift
//  Coin
//
//  Created by gnksbm on 8/20/24.
//

import Foundation

enum CreatePostError: Int, Error {
    case invalid = 401
    case forbidden = 403
    case createFailure = 410
    case tokenExpired = 419
}
