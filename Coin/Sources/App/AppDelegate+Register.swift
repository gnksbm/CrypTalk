//
//  AppDelegate+Register.swift
//  Coin
//
//  Created by gnksbm on 8/21/24.
//

import UIKit

extension AppDelegate {
    func registerDependency() {
        DIContainer.register(DefaultNetworkService(), type: NetworkService.self)
        DIContainer.register(DefaultAuthRepository(), type: AuthRepository.self)
    }
}
