//
//  CryptoCurrencyRepository.swift
//
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import RxSwift

public protocol CryptoCurrencyRepository {
    func readCryptoCurrency(coinID: String) -> Single<CryptoCurrencyResponse>
    func readCryptoCurrencies(page: Int) -> Single<[CryptoCurrencyResponse]>
    func searchCoin(query: String) -> Single<[SearchCoinResponse]>
    func readChartData(coinID: String, days: Int) -> Single<[ChartDataResponse]>
}
