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
    let provider = MoyaProvider<AuthTarget>()
    var disposeBag = DisposeBag()
    
    func testJoin() throws {
        var expectation = XCTestExpectation(description: "회원가입 통신 성공")
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
}
