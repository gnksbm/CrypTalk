//
//  CryptoCurrencyResponse.swift
//  
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

public struct CryptoCurrencyResponse {
    let marketCapRank: Int
    let id: String
    let symbol: String
    let name: String
    let price: Int
    
    public init(
        marketCapRank: Int,
        id: String,
        symbol: String,
        name: String,
        price: Int
    ) {
        self.marketCapRank = marketCapRank
        self.id = id
        self.symbol = symbol
        self.name = name
        self.price = price
    }
}
