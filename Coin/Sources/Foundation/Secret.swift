//
//  Secret.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import Foundation

enum Secret {
    static let apiKey =
    Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    static var apiKeyHeader =
    Bundle.main.object(forInfoDictionaryKey: "API_KEY_HEADER") as? String ?? ""
    static var baseURL =
    Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    static var port =
    Bundle.main.object(forInfoDictionaryKey: "PORT") as? String ?? ""
}
