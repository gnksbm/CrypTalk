//
//  AuthUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

protocol AuthUseCase {
    func validateEmail(request: EmailValidationRequest)
    func join(request: JoinRequest)
    func login(request: LoginRequest)
    func refreshToken(request: RefreshTokenRequest)
    func withdraw(request: WithdrawRequest)
}
