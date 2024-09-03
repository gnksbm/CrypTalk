//
//  ReadChartDataRequest.swift
//
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

public struct ReadChartDataRequest {
    public let coinID: String
    let days: String
    let precision: String?
    
    public init(
        coinID: String,
        days: String,
        precision: String?
    ) {
        self.coinID = coinID
        self.days = days
        self.precision = precision
    }
}

extension ReadChartDataRequest: QueryProvider {
    public var query: Query {
        Query(days: days, precision: precision)
    }
    
    public struct Query: Encodable {
        let baseCurrency = "krw"
        let days: String
        let precision: String?
        
        enum CodingKeys: String, CodingKey {
            case baseCurrency = "vs_currency"
            case days
            case precision
        }
    }
}
