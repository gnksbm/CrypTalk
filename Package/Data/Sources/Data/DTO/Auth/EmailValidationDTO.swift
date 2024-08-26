//
//  EmailValidationDTO.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Domain

struct EmailValidationDTO: Decodable {
    let message: String
}

extension EmailValidationDTO {
    func toResponse() -> EmptyResponse {
        EmptyResponse()
    }
}
