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
    case readCryptoCurrencies(ReadCryptoCurrenciesRequest)
    case readCryptoCurrencyWithID(ReadCryptoCurrencyWithIDRequest)
    
    public var targetPath: String {
        switch self {
        case .readCryptoCurrencies:
            "/coins/markets"
        case .readCryptoCurrencyWithID(let request):
            "/coins/\(request.coinID)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readCryptoCurrencies, .readCryptoCurrencyWithID:
            .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .readCryptoCurrencies(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        case .readCryptoCurrencyWithID:
            .requestPlain
        }
    }
    
    public var httpHeaders: [String : String] {
        switch self {
        case .readCryptoCurrencies, .readCryptoCurrencyWithID:
            [:]
        }
    }
    
    public var content: Content? {
        switch self {
        case .readCryptoCurrencies, .readCryptoCurrencyWithID:
            nil
        }
    }
}
