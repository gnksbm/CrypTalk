//
//  DefaultAuthUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

final class DefaultAuthUseCase: AuthUseCase {
    @Injected private var authRepository: AuthRepository
    
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    @UserDefaultsWrapper(key: .refreshToken, defaultValue: nil)
    private var refreshToken: String?
    
    func validateEmail(request: EmailValidationRequest) -> Single<Bool> {
        authRepository.validateEmail(request: request)
            .toResult()
    }
    
    func join(request: JoinRequest) -> Single<Bool> {
        authRepository.join(request: request)
            .toResult()
    }
    
    func login(request: LoginRequest) -> Single<Bool> {
        authRepository.login(request: request)
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
