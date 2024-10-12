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
        @UserDefaultsWrapper(
            key: .coinGeckoKey,
            defaultValue: CoinGeckoAPIKey.normal
        )
        var coinGeckoKey
        return ["x_cg_pro_api_key": coinGeckoKey.key]
    }
}

public enum CoinGeckoAPIKey: Codable {
    case normal, extra
    
    var key: String {
        switch self {
        case .normal:
            Secret.coinGeckoApiKey
        case .extra:
            Secret.coinGeckoApiKey2
        }
    }
    
    func getOtherCase() -> Self {
        switch self {
        case .normal:
            .extra
        case .extra:
            .normal
        }
    }
}
