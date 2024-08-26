//
//  CryptoCurrencyTarget.swift
//  
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import Domain

import Moya

public enum CryptoCurrencyTarget: CoinGeckoTargetType {
    case list(ReadCryptoCurrenciesRequest)
    
    public var targetPath: String {
        switch self {
        case .list:
            "/coins/markets"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .list:
            .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .list(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        }
    }
    
    public var httpHeaders: [String : String] {
        switch self {
        case .list:
            [:]
        }
    }
    
    public var content: Content? {
        switch self {
        case .list:
            nil
        }
    }
}
