//
//  ReadChartDataDTO.swift
//
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import CoinFoundation
import Domain

typealias ReadChartDataDTO = [[Double]]

extension ReadChartDataDTO {
    func toResponse() throws -> [ChartDataResponse] {
        try map { arr in
            guard let date = arr[safe: 0],
                  let openingPrice = arr[safe: 1],
                  let highestPrice = arr[safe: 2],
                  let lowestPrice = arr[safe: 3],
                  let closingPrice = arr[safe: 4] else {
                throw ReadChartDataDTOError.indexOutOfRange
            }
            return ChartDataResponse(
                date: date,
                openingPrice: openingPrice,
                highestPrice: highestPrice,
                lowestPrice: lowestPrice,
                closingPrice: closingPrice
            )
        }
    }
    
    enum ReadChartDataDTOError: Error {
        case indexOutOfRange
    }
}
