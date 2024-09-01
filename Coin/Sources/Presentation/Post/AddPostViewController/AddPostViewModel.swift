//
//  AddPostViewModel.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class AddPostViewModel: ViewModelType {
    private let cryptoName: String
    private let cryptoPostUseCase: CryptoPostUseCase
    
    init(
        cryptoName: String,
        cryptoPostUseCase: CryptoPostUseCase
    ) {
        self.cryptoPostUseCase = cryptoPostUseCase
        self.cryptoName = cryptoName
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            directionTitles: .just(MarketDirection.allCases.map { $0.toString }),
            doneButtonIsEnabled: input.textChangeEvent.map { !$0.isEmpty },
            finishFlow: PublishSubject<Void>()
        )
        
        disposeBag.insert {
            input.doneButtonTapEvent
                .withLatestFrom(input.textChangeEvent)
                .withLatestFrom(input.directionChangeEvent) { ($0, $1) }
                .withUnretained(self)
                .flatMap { vm, tuple in
                    let (content, direction) = tuple
                    return vm.cryptoPostUseCase.addPost(
                        cryptoName: vm.cryptoName,
                        direction: direction,
                        content: content,
                        imageData: []
                    )
                }
                .map { _ in }
                .subscribe(
                    onNext: { _ in
                        output.finishFlow.onNext(())
                    },
                    onError: { error in
                        Logger.error(error)
                    }
                )
        }
        
        return output
    }
}

extension AddPostViewModel {
    struct Input {
        let textChangeEvent: Observable<String>
        let directionChangeEvent: Observable<MarketDirection>
        let doneButtonTapEvent: Observable<Void>
    }
    
    struct Output { 
        let directionTitles: Observable<[String]>
        let doneButtonIsEnabled: Observable<Bool>
        let finishFlow: PublishSubject<Void>
    }
}
