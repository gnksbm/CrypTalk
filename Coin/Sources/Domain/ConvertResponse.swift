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

extension Single {
    func retry<E>(
        on errorCase: E,
        block: @escaping (Error) -> Observable<Element>
    ) -> Single<Element> where E: Error, E: RawRepresentable<Int> {
        asObservable()
            .catch { error in
            if let catching = error as? E {
                switch catching.rawValue {
                case errorCase.rawValue:
                    block(error)
                default:
                    .error(error)
                }
            } else {
                .error(error)
            }
        }
        .asSingle()
    }
    
    func retry<O: AnyObject, E>(
        with object: O,
        on errorCase: E,
        block: @escaping (O, E) -> Single<Element>
    ) -> Single<Element> where E: Error, E: RawRepresentable<Int> {
        { [weak object] in
            asObservable()
                .catch { error in
                    guard let object else { return .error(error) }
                    if let catching = error as? E {
                        switch catching.rawValue {
                        case errorCase.rawValue:
                            return block(object, errorCase).asObservable()
                        default:
                            return .error(error)
                        }
                    } else {
                        return .error(error)
                    }
            }
            .asSingle()
        }()
    }
}
