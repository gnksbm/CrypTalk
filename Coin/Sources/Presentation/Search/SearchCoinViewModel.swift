//
//  SearchCoinViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

protocol SearchCoinViewModelDelegate: AnyObject {
    func itemSelected(_ item: SearchCoinResponse)
}

final class SearchCoinViewModel: ViewModelType {
    private let searchCoinUseCase: SearchCoinUseCase
    private let viewType: ViewType
    
    weak var delegate: SearchCoinViewModelDelegate?
    
    init(
        searchCoinUseCase: SearchCoinUseCase,
        viewType: ViewType
    ) {
        self.searchCoinUseCase = searchCoinUseCase
        self.viewType = viewType
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            searchResult: PublishSubject(), 
            finishFlow: PublishSubject()
        )
        
        disposeBag.insert {
            input.searchBarReturnEvent
                .withLatestFrom(input.queryChangeEvent)
                .withUnretained(self)
                .flatMap { vm, query in
                    vm.searchCoinUseCase.search(query: query)
                }
                .catch { error in
                    Logger.error(error)
                    return .empty()
                }
                .bind(to: output.searchResult)
            
            input.itemSelectEvent
                .withUnretained(self)
                .map { vm, response in
                    vm.delegate?.itemSelected(response)
                    return vm.viewType
                }
                .bind(to: output.finishFlow)
        }
        
        return output
    }
    
    enum ViewType {
        case dismiss, next(BaseViewController)
    }
}

extension SearchCoinViewModel {
    struct Input { 
        let queryChangeEvent: Observable<String>
        let searchBarReturnEvent: Observable<Void>
        let itemSelectEvent: Observable<SearchCoinResponse>
    }
    
    struct Output { 
        let searchResult: PublishSubject<[SearchCoinResponse]>
        let finishFlow: PublishSubject<ViewType>
    }
}
