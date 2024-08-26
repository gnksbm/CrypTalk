//
//  AuthUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

protocol AuthUseCase {
    func validateEmail(email: String) -> Single<Bool>
    
    func join(
        email: String,
        password: String,
        nick: String,
        phoneNum: String?,
        birthDay: String?
    ) -> Single<Bool>
    
    func login(
        email: String,
        password: String
    ) -> Single<Bool>
    
    func requestRefreshToken() -> Single<Bool>
    
    func withdraw() -> Single<Bool>
}
