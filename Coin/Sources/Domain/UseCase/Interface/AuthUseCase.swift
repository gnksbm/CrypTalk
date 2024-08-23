//
//  AuthUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

protocol AuthUseCase {
    func validateEmail(request: EmailValidationRequest) -> Single<Bool>
    func join(request: JoinRequest) -> Single<Bool>
    func login(request: LoginRequest) -> Single<Bool>
    func requestRefreshToken() -> Single<Bool>
    func withdraw() -> Single<Bool>
}
