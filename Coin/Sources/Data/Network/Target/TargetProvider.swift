//
//  TargetProvider.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import Foundation

import Moya

protocol TargetProvider: TargetType {
    var scheme: Scheme { get }
    var host: String { get }
    var port: Int? { get }
    var httpHeaders: [String: String] { get }
    var commonHeaders: [String: String] { get }
    var content: Content? { get }
}

extension TargetProvider {
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.port = port
        guard let url = components.url else {
            fatalError("유효하지 않은 URL 구성: \(components)")
        }
        return url
    }
    
    var headers: [String : String]? {
        var headers = commonHeaders
        headers.merge(httpHeaders, uniquingKeysWith: { $1 })
        if let content {
            headers.merge(content.header, uniquingKeysWith: { $1 })
        }
        return headers
    }
}

enum Scheme: String {
    case http, https, ws
}

enum Content {
    case json, multipartFormData
    
    var header: [String: String] {
        switch self {
        case .json:
            ["Content-Type": "application/json"]
        case .multipartFormData:
            ["Content-Type": "multipart/form-data"]
        }
    }
}
