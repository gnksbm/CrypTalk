//
//  EmailValidationError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum EmailValidationError: Int, Error {
    case missingRequiredValue = 400
    case invalidEmail = 409
}
