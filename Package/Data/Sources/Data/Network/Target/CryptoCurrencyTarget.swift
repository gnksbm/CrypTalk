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
    case searchCoinWithID(SearchCoinWithIDRequest)
    case readChartData(ReadChartDataRequest)
    
    public var targetPath: String {
        switch self {
        case .readCryptoCurrencies:
            "/coins/markets"
        case .readCryptoCurrencyWithID(let request):
            "/coins/\(request.coinID)"
        case .searchCoinWithID:
            "/search"
        case .readChartData(let request):
            "/coins/\(request.coinID)/ohlc"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .readCryptoCurrencies, .readCryptoCurrencyWithID,
                .searchCoinWithID, .readChartData:
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
        case .searchCoinWithID(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        case .readChartData(let request):
            .requestParameters(
                parameters: request.toQuery(),
                encoding: URLEncoding.queryString
            )
        }
    }
    
    public var httpHeaders: [String : String] {
        switch self {
        case .readCryptoCurrencies, .readCryptoCurrencyWithID,
                .searchCoinWithID, .readChartData:
            [:]
        }
    }
    
    public var content: Content? {
        switch self {
        case .readCryptoCurrencies, .readCryptoCurrencyWithID,
                .searchCoinWithID, .readChartData:
            nil
        }
    }
}
