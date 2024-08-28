//
//  AuthRequestRetrier.swift
//  Coin
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

import CoinFoundation

import RxSwift

struct AuthRequestRetrier<Request: AccessTokenProvider, Response> {
    @Injected private var authRepository: AuthRepository
    @UserDefaultsWrapper(key: .refreshToken, defaultValue: "")
    private var refreshToken: String?
    
    let request: Request
    let stream: (Request) -> Single<Response>
    
    init(
        request: Request,
        stream: @escaping (_ request: Request) -> Single<Response>
    ) {
        self.request = request
        self.stream = stream
    }
    
    func execute() -> Single<Response> {
        stream(request)
            .retry(on: BackEndError.accessTokenExpired) { error in
                guard let refreshToken else {
                    return .error(error)
                }
                return authRepository.refreshToken(
                    request: RefreshTokenRequest(
                        accessToken: request.accessToken,
                        refreshToken: refreshToken
                    )
                )
                .flatMap { response in
                    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
                    var accessToken: String?
                    accessToken = response.accessToken
                    var newRequest = request
                    newRequest.accessToken = response.accessToken
                    return stream(newRequest)
                }
                .asObservable()
            }
    }
}
