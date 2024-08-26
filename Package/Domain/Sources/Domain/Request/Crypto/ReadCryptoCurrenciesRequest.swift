//
//  ReadCryptoCurrenciesRequest.swift
//  
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

public struct ReadCryptoCurrenciesRequest {
    let page: Int
    let perPage: Int
    
    public init(page: Int, perPage: Int = 250) {
        self.page = page
        self.perPage = perPage
    }
}

extension ReadCryptoCurrenciesRequest: QueryProvider {
    public var query: Query {
        Query(page: page, perPage: perPage)
    }
    
    public struct Query: Encodable {
        let order = "market_cap_asc"
        let baseCurrency = "krw"
        let page: String
        let perPage: String
        
        init(page: Int, perPage: Int) {
            self.page = String(page)
            self.perPage = String(perPage)
        }
        
        enum CodingKeys: String, CodingKey {
            case order
            case baseCurrency = "vs_currency"
            case page
            case perPage = "per_page"
        }
    }
}
