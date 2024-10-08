//
//  CoinListViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/2/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class CoinListViewModel: ViewModelType {
    private let useCase: CryptoPostUseCase
    
    init(useCase: CryptoPostUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            marketCap: PublishSubject(), 
            startPostFlow: input.itemSelected,
            startChartFlow: PublishSubject()
        )
        
        disposeBag.insert {
            input.viewWillAppearEvent
                .throttle(
                    .seconds(360),
                    scheduler: MainScheduler.instance
                )
                .withUnretained(self)
                .flatMap { vm, _ in
                    vm.useCase.fetchCryptoCurrencies(page: 1)
                }
                .bind(to: output.marketCap)
            
            input.chartButtonTapEvent
                .withUnretained(self)
                .flatMap { vm, response in
                    vm.useCase.fetchChartData(coinID: response.id, days: 1)
                        .map { (response.name, $0)}
                }
                .bind(to: output.startChartFlow)
        }
        
        return output
    }
}
extension CoinListViewModel {
    struct Input { 
        let viewWillAppearEvent: Observable<Void>
        let itemSelected: Observable<CryptoCurrencyResponse>
        let chartButtonTapEvent: Observable<CryptoCurrencyResponse>
    }
    
    struct Output { 
        let marketCap: PublishSubject<[CryptoCurrencyResponse]>
        let startPostFlow: Observable<CryptoCurrencyResponse>
        let startChartFlow:
        PublishSubject<(title: String, items: [ChartDataResponse])>
    }
}
