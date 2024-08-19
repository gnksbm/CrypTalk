//
//  LoginError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum LoginError: Int, Error {
    case missingRequiredValue = 400
    case invalidAccountValue = 401
}
