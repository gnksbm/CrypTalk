//
//  CandlestickRepresentable.swift
//  Coin
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

protocol CandlestickRepresentable {
    typealias Price = Double
    
    var date: Date { get }
    var openingPrice: Price { get }
    var highestPrice: Price { get }
    var lowestPrice: Price { get }
    var closingPrice: Price { get }
}

extension CandlestickRepresentable {
    var dailyRange: Price {
        highestPrice - lowestPrice
    }
    
    var fluctuation: Price {
        openingPrice - closingPrice
    }
    
    var candleKind: CandleKind {
        switch -fluctuation {
        case ..<0:
            return .black
        case 0:
            return .dodge
        default:
            return .white
        }
    }
}

extension Array<CandlestickRepresentable> {
    var chartOpeingPrice: Element.Price? {
        self.first?.openingPrice
    }
    
    var chartHighest: Element.Price? {
        self.lazy.map { $0.highestPrice }.max()
    }
    
    var chartLowest: Element.Price? {
        self.lazy.map { $0.lowestPrice }.min()
    }
}

enum CandleKind {
    case white, dodge, black
}

