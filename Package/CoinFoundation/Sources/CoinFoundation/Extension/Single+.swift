//
//  Single+.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

import Moya
import RxSwift

enum StreamError: Error {
    case DecodeError(Error)
}

public extension Single<Data> {
    func decode<T: Decodable>(type: T.Type) -> Single<T> {
        asObservable()
            .map {
                do {
                    return try JSONDecoder().decode(T.self, from: $0)
                } catch {
                    throw StreamError.DecodeError(error)
                }
            }
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
