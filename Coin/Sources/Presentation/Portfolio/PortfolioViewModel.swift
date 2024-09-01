//
//  PortfolioViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class PortfolioViewModel: ViewModelType {
    private let useCase: PortfolioUseCase
    private let userID: String?
    
    init(
        useCase: PortfolioUseCase,
        userID: String?
    ) {
        self.useCase = useCase
        self.userID = userID
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            portfolio: PublishSubject(),
            startLoginFlow: PublishSubject()
        )
        
        disposeBag.insert {
            input.viewWillAppearEvent
                .withUnretained(self)
                .flatMap { vm, _ in
                    if let userID = vm.userID {
                        vm.useCase.fetchPortfolio(userID: userID)
                    } else {
                        vm.useCase.fetchPortfolio()
                    }
                }
                .subscribe(
                    onNext: { response in
                        output.portfolio.onNext(response)
                    },
                    onError: { error in
                        if let error = error as? BackEndError,
                           case .refreshTokenExpired = error {
                            output.startLoginFlow.onNext(())
                        }
                    }
                )
        }
        
        return output
    }
}

extension PortfolioViewModel {
    struct Input { 
        let viewWillAppearEvent: Observable<Void>
    }
    struct Output {
        let portfolio: PublishSubject<PortfolioResponse>
        let startLoginFlow: PublishSubject<Void>
    }
}
