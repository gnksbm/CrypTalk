//
//  Single+.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya
import RxSwift

public extension Single<Data> {
    func decode<T: Decodable>(type: T.Type) -> Single<T> {
        asObservable()
            .decode(type: type, decoder: JSONDecoder())
            .asSingle()
    }
}

public extension Single<Moya.Response> {
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
