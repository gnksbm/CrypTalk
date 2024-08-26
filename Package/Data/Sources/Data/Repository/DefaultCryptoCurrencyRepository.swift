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

public final class DefaultCryptoCurrencyRepository: CryptoCurrencyRepository {
    @Injected private var networkService: NetworkService
    
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
}
