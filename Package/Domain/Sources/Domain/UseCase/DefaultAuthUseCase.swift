//
//  DefaultAuthUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import CoinFoundation

import RxSwift

final class DefaultAuthUseCase: AuthUseCase {
    @Injected private var authRepository: AuthRepository
    
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    @UserDefaultsWrapper(key: .refreshToken, defaultValue: nil)
    private var refreshToken: String?
    
    func validateEmail(email: String) -> RxSwift.Single<Bool> {
        authRepository.validateEmail(
            request: EmailValidationRequest(email: email)
        )
        .toResult()
    }
    
    func join(
        email: String,
        password: String,
        nick: String,
        phoneNum: String?,
        birthDay: String?
    ) -> RxSwift.Single<Bool> {
        authRepository.join(
            request: JoinRequest(
                email: email,
                password: password,
                nick: nick,
                phoneNum: phoneNum,
                birthDay: birthDay
            )
        )
        .toResult()
    }
    
    func login(email: String, password: String) -> RxSwift.Single<Bool> {
        authRepository.login(
            request: LoginRequest(
                email: email,
                password: password
            )
        )
        .asObservable()
        .withUnretained(self)
        .map { useCase, response in
            useCase.accessToken = response.accessToken
            useCase.refreshToken = response.refreshToken
            return true
        }
        .catchAndReturn(false)
        .asSingle()
    }
    
    func requestRefreshToken() -> Single<Bool> {
        guard let accessToken,
              let refreshToken else { return Single.just(false) }
        return authRepository.refreshToken(
            request: RefreshTokenRequest(
                accessToken: accessToken,
                refreshToken: refreshToken
            )
        )
        .asObservable()
        .withUnretained(self)
        .map { useCase, response in
            useCase.accessToken = response.accessToken
            return true
        }
        .catchAndReturn(false)
        .asSingle()
    }
    
    func withdraw() -> Single<Bool> {
        guard let accessToken else { return Single.just(false) }
        return authRepository.withdraw(
            request: WithdrawRequest(accessToken: accessToken)
        )
        .toResult()
    }
}
