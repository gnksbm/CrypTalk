//
//  File.swift
//  
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import CoinFoundation

import RxSwift

public final class DefaultSearchCoinUseCase: SearchCoinUseCase {
    @Injected private var cryptoCurrencyRepository: CryptoCurrencyRepository
    
    public init() { }
    
    public func search(query: String) -> Single<[SearchCoinResponse]> {
        cryptoCurrencyRepository.searchCoin(query: query)
    }
}
