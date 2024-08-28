//
//  CryptoPostViewModel.swift
//  Coin
//
//  Created by gnksbm on 8/28/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class CryptoPostViewModel: ViewModelType {
    private let useCase: CryptoPostUseCase
    private let coinID: String?
    
    init(
        useCase: CryptoPostUseCase,
        coinID: String? = nil
    ) {
        self.useCase = useCase
        self.coinID = coinID
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            cryptoCurrency: PublishSubject<CryptoCurrencyResponse>(), 
            cryptoPostResponse: PublishSubject<[PostResponse]>()
        )
        
        disposeBag.insert {
            input.viewWillAppearEvent
                .withUnretained(self)
                .flatMap { vm, _ in
                    vm.useCase.fetchCryptoCurrency(coinID: vm.coinID)
                }
                .withLatestFrom(input.pageChangeEvent) { ($0, $1) }
                .withUnretained(self)
                .flatMap { vm, tuple in
                    let (currencyResponse, page) = tuple
                    output.cryptoCurrency.onNext(currencyResponse)
                    return vm.useCase.fetchPosts(
                        cryptoName: currencyResponse.name,
                        page: page,
                        limit: 100
                    )
                }
                .bind(to: output.cryptoPostResponse)
        }
        
        return output
    }
}

extension CryptoPostViewModel {
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let pageChangeEvent: Observable<Int>
    }
    
    struct Output {
        let cryptoCurrency: PublishSubject<CryptoCurrencyResponse>
        let cryptoPostResponse: PublishSubject<[PostResponse]>
    }
}
