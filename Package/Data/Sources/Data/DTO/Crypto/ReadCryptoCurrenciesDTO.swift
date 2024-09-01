//
//  ReadCryptoCurrenciesDTO.swift
//
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import Domain

typealias ReadCryptoCurrenciesDTO = [ReadCryptoCurrency]

extension ReadCryptoCurrenciesDTO {
    func toResponse() -> [CryptoCurrencyResponse] {
        map {
            CryptoCurrencyResponse(
                id: $0.id,
                imageURL: URL(string: $0.image),
                marketCapRank: $0.marketCapRank,
                symbol: $0.symbol,
                name: $0.name,
                price: $0.currentPrice,
                rate: $0.priceChangePercentage24H
            )
        }
    }
}

struct ReadCryptoCurrency: Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Int
    let totalVolume, high24H, low24H: Int
    let priceChange24H, priceChangePercentage24H: Double
    let marketCapChange24H: Int
    let marketCapChangePercentage24H: Double
    let circulatingSupply, totalSupply, ath: Double
    let maxSupply: Double?
    let athChangePercentage: Double
    let athDate: String
    let atl, atlChangePercentage: Double
    let atlDate: String
    let roi: String?
    let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H
        = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
    }
}
