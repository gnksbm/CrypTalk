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
        do {
            let data = try JSONEncoder().encode(MarketDirection.decrease)
            print(String(data: data, encoding: .utf8))
        } catch {
            
        }
        DIContainer.register(DefaultNetworkService(), type: NetworkService.self)
        DIContainer.register(DefaultAuthRepository(), type: AuthRepository.self)
        #if FAKE
        DIContainer.register(FakePostRepository(), type: PostRepository.self)
        #elseif DEBUG
        DIContainer.register(DefaultPostRepository(), type: PostRepository.self)
        #endif
        DIContainer.register(
            DefaultCommentRepository(),
            type: CommentRepository.self
        )
        DIContainer.register(
            DefaultProfileRepository(),
            type: ProfileRepository.self
        )
        DIContainer.register(
            DefaultCryptoCurrencyRepository(),
            type: CryptoCurrencyRepository.self
        )
        DIContainer.register(
            DefaultPortfolioRepository(),
            type: PortfolioRepository.self
        )
    }
}
