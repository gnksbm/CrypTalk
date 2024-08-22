//
//  ProfileTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Coin
@testable import Moya
@testable import RxMoya
@testable import RxSwift

final class ProfileTargetTests: XCTestCase {
    private let provider = MoyaProvider<ProfileTarget>()
    private var disposeBag = DisposeBag()
    
    private var accessToken = "1"
    
    func testReadProfile() {
        testTarget(
            .readMyProfile(
                ReadMyProfileRequest(
                    accessToken: accessToken
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testUpdateProfile() {
        testTarget(
            .updateProfile(
                UpdateProfileRequest(
                    accessToken: accessToken,
                    nick: nil,
                    phoneNum: nil,
                    birthDay: nil,
                    profile: nil
                )
            ),
            successStatusCode: 401
        )
    }
    
    private func testTarget(_ target: ProfileTarget, successStatusCode: Int) {
        let expectation = XCTestExpectation(description: "\(target) 통신 성공")
        var statusCode: Int?
        provider.rx.request(target)
            .subscribe(
                onSuccess: { response in
                    if successStatusCode == response.statusCode {
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


