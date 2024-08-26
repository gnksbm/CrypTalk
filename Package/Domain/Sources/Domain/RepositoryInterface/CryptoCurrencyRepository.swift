//
//  CryptoCurrencyRepository.swift
//
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import RxSwift

public protocol CryptoCurrencyRepository {
    func readCryptoCurrencies(page: Int) -> Single<[CryptoCurrencyResponse]>
}
