//
//  MockAuthRepository.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

@testable import CoinFoundation
@testable import Domain
@testable import RxSwift

final class MockAuthRepository: AuthRepository {
    func validateEmail(
        request: EmailValidationRequest
    ) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.email == "Fail" {
                observer(.failure(BackEndError.alreadyUsedValue))
            } else {
                observer(.success(EmptyResponse()))
            }
            return Disposables.create()
        }
    }
    
    func join(request: JoinRequest) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.email == "Fail" {
                observer(.failure(BackEndError.alreadyUsedValue))
            } else {
                observer(.success(EmptyResponse()))
            }
            return Disposables.create()
        }
    }
    
    func login(request: LoginRequest) -> Single<LoginResponse> {
        Single.create { observer in
            if request.email == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(LoginResponse(userID: "", accessToken: "", refreshToken: "")))
            }
            return Disposables.create()
        }
    }
    
    func refreshToken(
        request: RefreshTokenRequest
    ) -> Single<RefreshTokenResponse> {
        @UserDefaultsWrapper(key: .accessToken, defaultValue: "Fail")
        var accessToken: String
        return Single.create { observer in
            if request.accessToken != "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
                accessToken = ""
            } else {
                observer(.success(RefreshTokenResponse(accessToken: "")))
                accessToken = "Fail"
            }
            return Disposables.create()
        }
    }
    
    func withdraw(request: WithdrawRequest) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(EmptyResponse()))
            }
            return Disposables.create()
        }
    }
}

