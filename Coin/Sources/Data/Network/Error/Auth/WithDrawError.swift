//
//  WithDrawError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum WithDrawError: Int, Error {
    case invalidToken = 401
    case forbidden = 403
    case expiredRefreshToken = 419
}
