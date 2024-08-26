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
    
    public var targetPath: String {
        switch self {
        case .readCryptoCurrencies:
            "/coins/markets"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readCryptoCurrencies:
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
        }
    }
    
    public var httpHeaders: [String : String] {
        switch self {
        case .readCryptoCurrencies:
            [:]
        }
    }
    
    public var content: Content? {
        switch self {
        case .readCryptoCurrencies:
            nil
        }
    }
}
