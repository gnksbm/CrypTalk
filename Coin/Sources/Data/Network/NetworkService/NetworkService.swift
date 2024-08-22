//
//  NetworkService.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

import RxSwift

protocol NetworkService {
    func request<T: TargetProvider>(target: T) -> Single<Data>
    func request<T: TargetProvider, E: Error>(
        target: T,
        errorType: E.Type
    ) -> Single<Data> where E: RawRepresentable<Int>
}
