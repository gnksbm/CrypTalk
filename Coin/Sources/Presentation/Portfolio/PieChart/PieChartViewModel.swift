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
            state.portfolio = response
        }
    }
}

extension PieChartViewModel {
    struct State {
        var portfolio = PortfolioResponse(portfolioID: "", assets: [])
    }
    
    enum Action {
        case updatePortfolio(PortfolioResponse)
    }
}
