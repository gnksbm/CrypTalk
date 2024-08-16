//
//  AuthTarget.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import Foundation

import Moya

enum AuthTarget {
    case login(LoginRequest), join(JoinRequest), validationEmail(EmailRequest)
    case refreshToken(RefreshTokenRequest), withdraw(WithDrawRequest)
}

extension AuthTarget: BackEndTargetType {
    var targetPath: String {
        switch self {
        case .login:
            "/users/login"
        case .join:
            "/users/join"
        case .validationEmail:
            "/validation/email"
        case .refreshToken:
            "/auth/refresh"
        case .withdraw:
            "/users/withdraw"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .join, .validationEmail:
            .post
        case .refreshToken, .withdraw:
            .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let request):
            .requestParameters(
                parameters: request.toParameter(),
                encoding: URLEncoding.httpBody
            )
        case .join(let request):
            .requestParameters(
                parameters: request.toParameter(),
                encoding: URLEncoding.httpBody
            )
        case .validationEmail(let request):
            .requestParameters(
                parameters: request.toParameter(),
                encoding: URLEncoding.httpBody
            )
        case .refreshToken, .withdraw:
            .requestPlain
        }
    }
    
    var commonHeaders: [String : String] {
        [Secret.apiKeyHeader: Secret.apiKey]
    }
    
    var httpHeaders: [String : String] {
        switch self {
        case .login, .join, .validationEmail:
            [:]
        case .refreshToken(let request):
            request.toHeader()
        case .withdraw(let request):
            request.toHeader()
        }
    }
    
    var content: Content? {
        switch self {
        case .login, .join, .validationEmail:
            .json
        case .refreshToken, .withdraw:
            nil
        }
    }
}
