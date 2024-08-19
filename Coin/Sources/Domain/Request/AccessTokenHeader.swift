//
//  AccessTokenHeader.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

struct AccessTokenHeader: Encodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "Authorization"
    }
}
