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
            cryptoCurrency: PublishSubject(),
            cryptoPostResponse: PublishSubject(),
            likeChanged: PublishSubject(),
            startAddFlow: PublishSubject(),
            startDetailFlow: Observable.merge(
                input.cellTapEvent,
                input.commentButtonTapEvent
            ), 
            startLoginFlow: PublishSubject()
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
                        limit: 5
                    )
                }
                .subscribe(
                    onNext: { responses in
                        output.cryptoPostResponse.onNext(responses)
                    },
                    onError: { error in
                        Logger.error(error)
                        output.startLoginFlow.onNext(())
                    }
                )
            
            input.plusButtonTapEvent
                .withLatestFrom(output.cryptoCurrency)
                .map { $0.name }
                .bind(to: output.startAddFlow)
            
            input.likeButtonTapEvent
                .withUnretained(self)
                .flatMap { vm, response in
                    vm.useCase.likePost(
                        post: response
                    )
                }
                .subscribe(
                    onNext: { response in
                        output.likeChanged.onNext(response)
                    },
                    onError: { error in
                        Logger.error(error)
                        output.startLoginFlow.onNext(())
                    }
                )
        }
        
        return output
    }
}

extension CryptoPostViewModel {
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let pageChangeEvent: Observable<Int>
        let plusButtonTapEvent: Observable<Void>
        let cellTapEvent: Observable<PostResponse>
        let likeButtonTapEvent: Observable<PostResponse>
        let commentButtonTapEvent: Observable<PostResponse>
    }
    
    struct Output {
        let cryptoCurrency: PublishSubject<CryptoCurrencyResponse>
        let cryptoPostResponse: PublishSubject<[PostResponse]>
        let likeChanged: PublishSubject<PostResponse>
        let startAddFlow: PublishSubject<String>
        let startDetailFlow: Observable<PostResponse>
        let startLoginFlow: PublishSubject<Void>
    }
}
