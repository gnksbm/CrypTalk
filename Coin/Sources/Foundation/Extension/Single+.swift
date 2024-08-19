//
//  Single+.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya
import RxSwift

extension Single<Moya.Response> {
    func catchError<T: Error>(
        errorType: T.Type
    ) -> Self where T: RawRepresentable<Int> {
        map { response in
            if let error = T(rawValue: response.statusCode) {
                throw error
            }
            return response
        }
    }
}
