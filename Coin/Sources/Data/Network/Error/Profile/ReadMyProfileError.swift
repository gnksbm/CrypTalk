//
//  ReadMyProfileError.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

enum ReadMyProfileError: Int, Error {
    case invalidToken = 401
    case forbidden = 403
    case tokenExpired = 419
}
