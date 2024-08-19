//
//  AuthError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum JoinError: Int, Error {
    case missingRequiredValue = 400
    case aleadyJoined = 409
}
