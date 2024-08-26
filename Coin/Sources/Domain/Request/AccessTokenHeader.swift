//
//  AccessTokenHeader.swift
//  Coin
//
//  Created by gnksbm on 8/18/24.
//

import Foundation

protocol AccessTokenProvider: HeaderProvider {
    var accessToken: String { get set }
}

extension AccessTokenProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}

struct AccessTokenHeader: Encodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "Authorization"
    }
}
