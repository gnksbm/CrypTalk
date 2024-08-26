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
        DIContainer.register(DefaultAuthRepository(), type: AuthRepository.self)
        DIContainer.register(DefaultPostRepository(), type: PostRepository.self)
        DIContainer.register(
            DefaultCommentRepository(),
            type: CommentRepository.self
        )
        DIContainer.register(
            DefaultProfileRepository(),
            type: ProfileRepository.self
        )
    }
}
