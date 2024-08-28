//
//  ReadCryptoCurrencyWithIDRequest.swift
//
//
//  Created by gnksbm on 8/28/24.
//

import Foundation

public struct ReadCryptoCurrencyWithIDRequest {
    public let coinID: String
    
    public init(coinID: String) {
        self.coinID = coinID
    }
}
