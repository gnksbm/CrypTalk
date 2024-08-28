//
//  CryptoCurrencyResponse.swift
//  
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

public struct CryptoCurrencyResponse {
    public let id: String
    public let imageURL: URL?
    public let marketCapRank: Int
    public let symbol: String
    public let name: String
    public let price: Double
    public let rate: Double
    
    public init(
        id: String,
        imageURL: URL?,
        marketCapRank: Int,
        symbol: String,
        name: String,
        price: Double,
        rate: Double
    ) {
        self.id = id
        self.imageURL = imageURL
        self.marketCapRank = marketCapRank
        self.symbol = symbol
        self.name = name
        self.price = price
        self.rate = rate
    }
}
