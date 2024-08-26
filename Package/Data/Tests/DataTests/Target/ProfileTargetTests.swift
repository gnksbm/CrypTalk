//
//  ProfileTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Data
@testable import Domain
@testable import Moya
@testable import RxSwift

final class ProfileTargetTests: XCTestCase {
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
        Single<Response>.create { observer in
            MoyaProvider<ProfileTarget>().request(target) { result in
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


