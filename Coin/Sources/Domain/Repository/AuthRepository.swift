//
//  AuthRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

protocol AuthRepository {
    func validateEmail(request: EmailValidationRequest) -> Single<EmptyResponse>
    func requestJoin(request: JoinRequest) -> Single<JoinResponse>
    func login(request: LoginRequest) -> Single<LoginResponse>
    func refreshToken(
        request: RefreshTokenRequest
    ) -> Single<RefreshTokenResponse>
    func withdraw(request: WithdrawRequest) -> Single<EmptyResponse>
}
