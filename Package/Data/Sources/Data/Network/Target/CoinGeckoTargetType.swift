//
//  CoinGeckoTargetType.swift
//
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import CoinFoundation

public protocol CoinGeckoTargetType: TargetProvider {
    var targetPath: String { get }
    var version: Int { get }
}

extension CoinGeckoTargetType {
    public var version: Int { 3 }
}

extension CoinGeckoTargetType {
    public var scheme: Scheme { .https }
    public var host: String { "api.coingecko.com" }
    public var port: Int? { nil }
    public var path: String { "/api/v\(version)\(targetPath)" }
    public var commonHeaders: [String : String] {
        [Secret.apiKeyHeader: Secret.coinGeckoApiKey]
    }
}
