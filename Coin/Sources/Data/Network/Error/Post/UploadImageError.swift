//
//  UploadImageError.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum UploadImageError: Int, Error {
    case missingRequiredValue = 400
    case invalidToken = 401
    case forbidden = 403
    case tokenExpired = 419
}
