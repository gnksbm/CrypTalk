//
//  DefaultNetworkService.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

import CoinFoundation

import RxSwift
import Moya

public final class DefaultNetworkService: NetworkService {
    public init() { }
    
    public func request<T: TargetProvider>(target: T) -> Single<Data> {
        Single<Data>.create { observer in
            let provider = MoyaProvider<T>()
            provider.request(target) { result in
                switch result {
                case .success(let success):
                    observer(.success(success.data))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func request<T: TargetProvider, E: Error>(
        target: T,
        errorType: E.Type
    ) -> Single<Data> where E: RawRepresentable<Int> {
        Single<Data>.create { observer in
            let provider = MoyaProvider<T>()
            provider.request(target) { result in
                switch result {
                case .success(let success):
                    if let error = E(rawValue: success.statusCode) {
                        observer(.failure(error))
                        Logger.error(error, with: target.self)
                        return
                    }
                    observer(.success(success.data))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
