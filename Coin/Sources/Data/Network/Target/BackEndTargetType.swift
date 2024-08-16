//
//  BackEndTargetType.swift
//  Coin
//
//  Created by gnksbm on 8/16/24.
//

import Foundation

protocol BackEndTargetType: TargetProvider {
    var targetPath: String { get }
    var version: Int { get }
}

extension BackEndTargetType {
    var version: Int { 1 }
}

extension BackEndTargetType {
    var scheme: Scheme { .http }
    var host: String { Secret.baseURL }
    var port: Int? { Int(Secret.port) }
    var path: String { "/v\(version)\(targetPath)" }
}
