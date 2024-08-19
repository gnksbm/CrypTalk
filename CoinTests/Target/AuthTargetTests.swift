//
//  CoinTests.swift
//  AuthTargetTests
//
//  Created by gnksbm on 8/16/24.
//

import XCTest

@testable import Coin
@testable import Moya
@testable import RxMoya
@testable import RxSwift

final class AuthTargetTests: XCTestCase {
    private let provider = MoyaProvider<AuthTarget>()
    private var disposeBag = DisposeBag()
    
    func testJoin() throws {
        let expectation = XCTestExpectation(description: "회원가입 통신 성공")
        var statusCode: Int?
        provider.rx.request(
            .join(
                JoinRequest(
                    email: "",
                    password: "",
                    nick: "",
                    phoneNum: nil,
                    birthDay: nil
                )
            )
        )
        .subscribe(
            onSuccess: { response in
                if [200, 400, 409].contains(response.statusCode) {
                    statusCode = response.statusCode
                }
                expectation.fulfill()
            },
            onFailure: { error in
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        )
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertNotNil(statusCode)
        disposeBag = DisposeBag()
    }
    
    func testValidationEmail() throws {
        let expectation = XCTestExpectation(description: "이메일 중복확인 통신 성공")
        var statusCode: Int?
        provider.rx.request(
            .validationEmail(
                EmailRequest(
                    email: "a@a.a"
                )
            )
        )
        .subscribe(
            onSuccess: { response in
                if [200, 400, 409].contains(response.statusCode) {
                    statusCode = response.statusCode
                }
                expectation.fulfill()
            },
            onFailure: { error in
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        )
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertNotNil(statusCode)
        disposeBag = DisposeBag()
    }
    
    func testLogin() throws {
        let expectation = XCTestExpectation(description: "로그인 통신 성공")
        var statusCode: Int?
        provider.rx.request(
            .login(
                LoginRequest(
                    email: "a@a.a",
                    password: "a@a.a"
                )
            )
        )
        .subscribe(
            onSuccess: { response in
                if [200, 400, 401].contains(response.statusCode) {
                    statusCode = response.statusCode
                }
                expectation.fulfill()
            },
            onFailure: { error in
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        )
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertNotNil(statusCode)
        disposeBag = DisposeBag()
    }
    
    func testRefreshToken() throws {
        let expectation = XCTestExpectation(description: "토큰 갱신 통신 성공")
        var statusCode: Int?
        provider.rx.request(
            .refreshToken(
                RefreshTokenRequest(
                    refreshToken: "a"
                )
            )
        )
        .subscribe(
            onSuccess: { response in
                if [200, 401, 403, 418].contains(response.statusCode) {
                    statusCode = response.statusCode
                }
                expectation.fulfill()
            },
            onFailure: { error in
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        )
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertNotNil(statusCode)
        disposeBag = DisposeBag()
    }
    
    func testWithDraw() throws {
        let expectation = XCTestExpectation(description: "회원탈퇴 통신 성공")
        var statusCode: Int?
        provider.rx.request(
            .withdraw(
                WithDrawRequest(
                    accessToken: "a"
                )
            )
        )
        .subscribe(
            onSuccess: { response in
                if [200, 401, 403, 419].contains(response.statusCode) {
                    statusCode = response.statusCode
                }
                expectation.fulfill()
            },
            onFailure: { error in
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        )
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertNotNil(statusCode)
        disposeBag = DisposeBag()
    }
}
