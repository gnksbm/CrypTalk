//
//  AppDelegate+Register.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import UIKit

import CoinFoundation
import Domain
import Data

extension AppDelegate {
    func registerDependency() {
        DIContainer.register(DefaultNetworkService(), type: NetworkService.self)
//        DIContainer.register(DefaultAuthRepository(), type: AuthRepository.self)
        #if FAKE
        DIContainer.register(FakePostRepository(), type: PostRepository.self)
        DIContainer.register(
            FakeProfileRepository(),
            type: ProfileRepository.self
        )
        DIContainer.register(
            FakePortfolioRepository(),
            type: PortfolioRepository.self
        )
        #else
        DIContainer.register(DefaultPostRepository(), type: PostRepository.self)
        DIContainer.register(
            DefaultProfileRepository(),
            type: ProfileRepository.self
        )
        DIContainer.register(
            DefaultPortfolioRepository(),
            type: PortfolioRepository.self
        )
        #endif
//        DIContainer.register(
//            DefaultCommentRepository(),
//            type: CommentRepository.self
//        )
        DIContainer.register(
            DefaultCryptoCurrencyRepository(),
            type: CryptoCurrencyRepository.self
        )
    }
}
