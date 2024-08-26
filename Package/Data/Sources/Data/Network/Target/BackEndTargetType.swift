//
//  BackEndTargetType.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

import CoinFoundation
import Domain

public protocol BackEndTargetType: TargetProvider {
    var targetPath: String { get }
    var version: Int { get }
}

extension BackEndTargetType {
    public var version: Int { 1 }
}

extension BackEndTargetType {
    public var scheme: Scheme { .http }
    public var host: String { Secret.baseURL }
    public var port: Int? { Int(Secret.port) }
    public var path: String { "/v\(version)\(targetPath)" }
    public var commonHeaders: [String : String] {
        [Secret.apiKeyHeader: Secret.apiKey]
    }
}
