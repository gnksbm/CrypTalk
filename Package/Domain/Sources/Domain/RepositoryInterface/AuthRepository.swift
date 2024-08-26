//
//  AuthRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

public protocol AuthRepository {
    func validateEmail(request: EmailValidationRequest) -> Single<EmptyResponse>
    func join(request: JoinRequest) -> Single<EmptyResponse>
    func login(request: LoginRequest) -> Single<LoginResponse>
    func refreshToken(
        request: RefreshTokenRequest
    ) -> Single<RefreshTokenResponse>
    func withdraw(request: WithdrawRequest) -> Single<EmptyResponse>
}
