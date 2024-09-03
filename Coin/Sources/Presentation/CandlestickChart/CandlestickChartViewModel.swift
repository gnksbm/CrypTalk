//
//  CandlestickChartViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class CandlestickChartViewModel: ViewModelType {
    private let title: String
    private let items: [ChartDataResponse]
    
    init(
        title: String,
        items: [ChartDataResponse]
    ) {
        self.title = title
        self.items = items
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            navigationTitle: PublishSubject<String>(),
            chartData: PublishSubject<[ChartDataResponse]>()
        )
        
        disposeBag.insert {
            input.viewWillAppearEvent
                .bind(with: self) { vm, _ in
                    output.navigationTitle.onNext(vm.title)
                }
            
            input.viewDidAppearEvent
                .bind(with: self) { vm, _ in
                    output.chartData.onNext(vm.items)
                }
        }
        
        return output
    }
}

extension CandlestickChartViewModel {
    struct Input { 
        let viewWillAppearEvent: Observable<Void>
        let viewDidAppearEvent: Observable<Void>
    }
    
    struct Output {
        let navigationTitle: PublishSubject<String>
        let chartData: PublishSubject<[ChartDataResponse]>
    }
}
 
