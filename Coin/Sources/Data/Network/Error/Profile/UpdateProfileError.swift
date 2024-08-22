//
//  UpdateProfileError.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

enum UpdateProfileError: Int, Error {
    case invalidToken = 401
    case containWhiteSpace = 402
    case forbidden = 403
    case tokenExpired = 419
}
