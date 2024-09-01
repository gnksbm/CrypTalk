//
//  SearchCoinUseCase.swift
//
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

import RxSwift

public protocol SearchCoinUseCase {
    func search(query: String) -> Single<[SearchCoinResponse]>
}
