//
//  PieChartViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import Domain

final class PieChartViewModel: ObservableObject {
    @Published var state = State()
    
    func reduce(action: Action) {
        switch action {
        case .updatePortfolio(let response):
            if response.assets.isEmpty {
                state.portfolio = .empty
            } else {
                state.portfolio = .loaded(response.assets) 
            }
        }
    }
}

extension PieChartViewModel {
    struct State {
        var portfolio = PortfolioState.loading
        
        enum PortfolioState {
            case loading
            case empty
            case loaded([CryptoAsset])
        }
    }
    
    enum Action {
        case updatePortfolio(PortfolioResponse)
    }
}
