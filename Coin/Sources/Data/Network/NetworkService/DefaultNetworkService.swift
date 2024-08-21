//
//  DefaultNetworkService.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import Foundation

import RxSwift
import Moya

final class DefaultNetworkService: NetworkService {
    func request<T: TargetProvider>(target: T) -> Single<Data> {
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
    
    func request<T: TargetProvider, E: Error>(
        target: T,
        error: E
    ) -> Single<Data> where E: RawRepresentable<Int> {
        Single<Data>.create { observer in
           let provider = MoyaProvider<T>()
            provider.request(target) { result in
                switch result {
                case .success(let success):
                    guard let error = E(rawValue: success.statusCode) else {
                        observer(.failure(error))
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
