//
//  DefaultAuthRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

final class DefaultAuthRepository: AuthRepository {
    @Injected private var networkService: NetworkService
    
    func validateEmail(request: EmailValidationRequest) -> Single<EmptyResponse> {
        networkService.request(
            target: AuthTarget.validationEmail(request),
            errorType: EmailValidationError.self
        )
        .decode(type: EmailValidationDTO.self)
        .map { $0.toResponse() }
    }
    
    func requestJoin(request: JoinRequest) -> Single<JoinResponse> {
        networkService.request(
            target: AuthTarget.join(request),
            errorType: JoinError.self
        )
        .decode(type: JoinDTO.self)
        .map { $0.toResponse() }
    }
    
    func login(request: LoginRequest) -> Single<LoginResponse> {
        networkService.request(
            target: AuthTarget.login(request),
            errorType: LoginError.self
        )
        .decode(type: LoginDTO.self)
        .map { $0.toResponse() }
    }
    
    func refreshToken(
        request: RefreshTokenRequest
    ) -> Single<RefreshTokenResponse> {
        networkService.request(
            target: AuthTarget.refreshToken(request),
            errorType: RefreshTokenError.self
        )
        .decode(type: RefreshTokenDTO.self)
        .map { $0.toResponse() }
    }
    
    func withdraw(request: WithdrawRequest) -> Single<EmptyResponse> {
        networkService.request(
            target: AuthTarget.withdraw(request),
            errorType: WithdrawError.self
        )
        .decode(type: WithdrawDTO.self)
        .map { $0.toResponse() }
    }
}
