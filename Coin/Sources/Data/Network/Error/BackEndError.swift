//
//  BackEndError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum BackEndError: Int, Error {
    case invalidAuthKey = 420
    case excessiveRequest = 429
    case invalidURL = 444
    case serverError = 500
}
