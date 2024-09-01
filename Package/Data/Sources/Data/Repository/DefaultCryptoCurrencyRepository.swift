//
//  DefaultCryptoCurrencyRepository.swift
//
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

// TODO: 요청이 1분에 30번 제약이 있기에 어떻게 처리할지 생각해야함   https://docs.coingecko.com/v3.0.1/reference/common-errors-rate-limit#:~:text=For%20Public%20API%20user%20(Demo%20plan)%2C%20the%20rate%20limit%20is%20~30%20calls%20per%20minutes%20and%20it%20varies%20depending%20on%20the%20traffic%20size.
public final class DefaultCryptoCurrencyRepository: CryptoCurrencyRepository {
    @Injected private var networkService: NetworkService
    
    public init() { }
    
    public func readCryptoCurrency(
        coinID: String
    ) -> Single<CryptoCurrencyResponse> {
        networkService.request(
            target: CryptoCurrencyTarget.readCryptoCurrencyWithID(
                ReadCryptoCurrencyWithIDRequest(coinID: coinID)
            )
        )
        .decode(type: ReadCryptoCurrencyWithIDDTO.self)
        .map { try $0.toResponse() }   
    }
    
    public func readCryptoCurrencies(
        page: Int
    ) -> Single<[CryptoCurrencyResponse]> {
        networkService.request(
            target: CryptoCurrencyTarget.readCryptoCurrencies(
                ReadCryptoCurrenciesRequest(page: page)
            )
        )
        .decode(type: ReadCryptoCurrenciesDTO.self)
        .map { $0.toResponse() }
    }
    
    public func searchCoin(query: String) -> Single<[SearchCoinResponse]> {
        networkService.request(
            target: CryptoCurrencyTarget.searchCoinWithID(
                SearchCoinWithIDRequest(
                    query: query
                )
            )
        )
        .decode(type: SearchCoinWithIDDTO.self)
        .map { $0.toResponse() }
    }
}
