//
//  ChartDataResponse.swift
//  
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import CoinFoundation

public struct ChartDataResponse: CandlestickRepresentable, Equatable {
    public let date: Date
    public let openingPrice: Price
    public let highestPrice: Price
    public let lowestPrice: Price
    public let closingPrice: Price
    
    public init(
        date: Price,
        openingPrice: Price,
        highestPrice: Price,
        lowestPrice: Price,
        closingPrice: Price
    ) {
        self.date = Date(timeIntervalSince1970: date)
        self.openingPrice = openingPrice
        self.highestPrice = highestPrice
        self.lowestPrice = lowestPrice
        self.closingPrice = closingPrice
    }
}
