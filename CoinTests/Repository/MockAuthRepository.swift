//
//  MockAuthRepository.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

@testable import Coin
@testable import RxSwift

final class MockAuthRepository<T: AnyObject>: AuthRepository {
    private let bundle: T.Type
    
    init(bundle: T.Type) {
        self.bundle = bundle
    }
    
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
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Login",
                        dtoType: LoginDTO.self
                    )
                    observer(.success(dto.toResponse()))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func refreshToken(
        request: RefreshTokenRequest
    ) -> Single<RefreshTokenResponse> {
        Single.create { observer in
            if request.accessToken != "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "RefreshToken",
                        dtoType: RefreshTokenDTO.self
                    )
                    observer(.success(dto.toResponse()))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func withdraw(request: WithdrawRequest) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Login",
                        dtoType: WithdrawDTO.self
                    )
                    observer(.success(dto.toResponse()))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

