//
//  ConvertResponse.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

extension Single<EmptyResponse> {
    func toResult() -> Single<Bool> {
        map { _ in true }
            .catchAndReturn(false)
    }
}
