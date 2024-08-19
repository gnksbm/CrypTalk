//
//  LikeTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Coin
@testable import Moya
@testable import RxMoya
@testable import RxSwift

final class LikeTargetTests: XCTestCase {
    private let provider = MoyaProvider<LikeTarget>()
    private var disposeBag = DisposeBag()
    
    private var accessToken = "1"
    
    func testUpdateLike() {
        testTarget(
            .updateLike(
                UpdateLikeRequest(
                    accessToken: accessToken,
                    postID: "",
                    likeStatus: true
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testReadLikedPosts() {
        testTarget(
            .readLikedPosts(
                ReadLikedPostsRequest(
                    accessToken: accessToken
                )
            ),
            successStatusCode: 401
        )
    }
    
    private func testTarget(_ target: LikeTarget, successStatusCode: Int) {
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

