//
//  CoinTests.swift
//  AuthTargetTests
//
//  Created by gnksbm on 8/16/24.
//

import XCTest

@testable import Data
@testable import Domain
@testable import Moya
@testable import RxSwift

final class AuthTargetTests: XCTestCase {
    private var disposeBag = DisposeBag()
    
    func testJoin() throws {
        testTarget(
            .join(
                JoinRequest(
                    email: "",
                    password: "",
                    nick: "",
                    phoneNum: nil,
                    birthDay: nil
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testValidationEmail() throws {
        testTarget(
            .validationEmail(
                EmailValidationRequest(
                    email: "a@a.a"
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testLogin() throws {
        testTarget(
            .login(
                LoginRequest(
                    email: "a@a.a",
                    password: "a@a.a"
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testRefreshToken() throws {
        testTarget(
            .refreshToken(
                RefreshTokenRequest(
                    accessToken: "",
                    refreshToken: "a"
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testWithdraw() throws {
        testTarget(
            .withdraw(
                WithdrawRequest(
                    accessToken: "a"
                )
            ),
            successStatusCode: 401
        )
    }
    
    private func testTarget(_ target: AuthTarget, successStatusCode: Int) {
        let expectation = XCTestExpectation(description: "\(target) 통신 성공")
        var statusCode: Int?
        Single<Response>.create { observer in
            MoyaProvider<AuthTarget>().request(target) { result in
                switch result {
                case .success(let response):
                    if successStatusCode == response.statusCode {
                        statusCode = response.statusCode
                    }
                    expectation.fulfill()
                case .failure(let error):
                    XCTExpectFailure(error.localizedDescription)
                    expectation.fulfill()
                }
            }
            return Disposables.create()
        }
        .subscribe()
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertNotNil(statusCode)
        disposeBag = DisposeBag()
    }
}
