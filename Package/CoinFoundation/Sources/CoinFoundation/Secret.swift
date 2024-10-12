//
//  Secret.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import Foundation

public enum Secret {
    public static let coinGeckoApiKey =
    Bundle.main.object(
        forInfoDictionaryKey: "COIN_GECKO_API_KEY"
    ) as? String ?? ""
    public static let coinGeckoApiKey2 =
    Bundle.main.object(
        forInfoDictionaryKey: "COIN_GECKO_API_KEY2"
    ) as? String ?? ""
    public static let apiKey =
    Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    public static var apiKeyHeader =
    Bundle.main.object(forInfoDictionaryKey: "API_KEY_HEADER") as? String ?? ""
    public static var baseURL =
    Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    public static var port =
    Bundle.main.object(forInfoDictionaryKey: "PORT") as? String ?? ""
}
