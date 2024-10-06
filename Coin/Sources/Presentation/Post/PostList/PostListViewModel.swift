//
//  PostListViewModel.swift
//  Coin
//
//  Created by gnksbm on 8/28/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class PostListViewModel: ViewModelType {
    private let useCase: CryptoPostUseCase
    private var coinID: String?
    
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
            startLoginFlow: PublishSubject(),
            startSearchFlow: input.titleTapEvent,
            startProfileFlow: input.profileButtonTapEvent
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
                .catch { error in
                    Logger.error(error)
                    if let error = error as? BackEndError,
                       case .unauthorized = error {
                        output.startLoginFlow.onNext(())
                    }
                    return .empty()
                }
                .bind { responses in
                    output.cryptoPostResponse.onNext(responses)
                }
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
                .catch { error in
                    Logger.error(error)
                    if let error = error as? BackEndError,
                       case .unauthorized = error {
                        output.startLoginFlow.onNext(())
                    }
                    return .empty()
                }
                .bind { response in
                    output.likeChanged.onNext(response)
                }
        }
        
        return output
    }
}

extension PostListViewModel {
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let pageChangeEvent: Observable<Int>
        let plusButtonTapEvent: Observable<Void>
        let titleTapEvent: Observable<Void>
        let cellTapEvent: Observable<PostResponse>
        let likeButtonTapEvent: Observable<PostResponse>
        let commentButtonTapEvent: Observable<PostResponse>
        let profileButtonTapEvent: Observable<Void>
    }
    
    struct Output {
        let cryptoCurrency: PublishSubject<CryptoCurrencyResponse>
        let cryptoPostResponse: PublishSubject<[PostResponse]>
        let likeChanged: PublishSubject<PostResponse>
        let startAddFlow: PublishSubject<String>
        let startDetailFlow: Observable<PostResponse>
        let startLoginFlow: PublishSubject<Void>
        let startSearchFlow: Observable<Void>
        let startProfileFlow: Observable<Void>
    }
}

extension PostListViewModel: SearchCoinViewModelDelegate {
    func itemSelected(_ item: SearchCoinResponse) {
        coinID = item.id
    }
}
