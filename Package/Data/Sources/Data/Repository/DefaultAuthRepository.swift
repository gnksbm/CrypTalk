//
//  DefaultAuthRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

public final class DefaultAuthRepository: AuthRepository {
    @Injected private var networkService: NetworkService
    
    public init() { }
    
    public func validateEmail(
        request: EmailValidationRequest
    ) -> Single<EmptyResponse> {
        networkService.request(
            target: AuthTarget.validationEmail(request),
            errorType: BackEndError.self
        )
        .decode(type: EmailValidationDTO.self)
        .map { $0.toResponse() }
    }
    
    public func join(request: JoinRequest) -> Single<EmptyResponse> {
        networkService.request(
            target: AuthTarget.join(request),
            errorType: BackEndError.self
        )
        .decode(type: JoinDTO.self)
        .map { $0.toResponse() }
    }
    
    public func login(request: LoginRequest) -> Single<LoginResponse> {
        networkService.request(
            target: AuthTarget.login(request),
            errorType: BackEndError.self
        )
        .decode(type: LoginDTO.self)
        .map { $0.toResponse() }
    }
    
    public func refreshToken(
        request: RefreshTokenRequest
    ) -> Single<RefreshTokenResponse> {
        networkService.request(
            target: AuthTarget.refreshToken(request),
            errorType: BackEndError.self
        )
        .decode(type: RefreshTokenDTO.self)
        .map { $0.toResponse() }
    }
    
    public func withdraw(request: WithdrawRequest) -> Single<EmptyResponse> {
        networkService.request(
            target: AuthTarget.withdraw(request),
            errorType: BackEndError.self
        )
        .decode(type: WithdrawDTO.self)
        .map { $0.toResponse() }
    }
}
