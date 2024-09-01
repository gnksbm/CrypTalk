//
//  SearchCoinWithIDDTO.swift
//
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import Domain

struct SearchCoinWithIDDTO: Codable {
    let coins: [CoinDTO]
}

extension SearchCoinWithIDDTO {
    func toResponse() -> [SearchCoinResponse] {
        coins.map { $0.toResponse() }
    }
}

struct CoinDTO: Codable {
    let id, name, apiSymbol, symbol: String
    let marketCapRank: Int
    let thumb, large: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb, large
    }
}

extension CoinDTO {
    func toResponse() -> SearchCoinResponse {
        SearchCoinResponse(
            id: id,
            name: name,
            iconURL: thumb
        )
    }
}
