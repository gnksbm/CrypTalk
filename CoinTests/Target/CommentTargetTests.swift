//
//  CommentTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Coin
@testable import Moya
@testable import RxMoya
@testable import RxSwift

final class CommentTargetTests: XCTestCase {
    private let provider = MoyaProvider<CommentTarget>()
    private var disposeBag = DisposeBag()
    
    private var accessToken = "1"
    
    func testCreateComment() { 
        testTarget(
            .createComment(
                CreateCommentRequest(
                    accessToken: accessToken,
                    postID: "",
                    content: ""
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testUpdateComment() {
        testTarget(
            .updateComment(
                UpdateCommentRequest(
                    accessToken: accessToken,
                    postID: "",
                    commentID: "",
                    content: ""
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testDeleteComment() {
        testTarget(
            .deleteComment(
                DeleteCommentRequest(
                    accessToken: accessToken,
                    postID: "",
                    commentID: "",
                    content: ""
                )
            ),
            successStatusCode: 401
        )
    }
    
    private func testTarget(_ target: CommentTarget, successStatusCode: Int) {
        let expectation = XCTestExpectation(description: "회원가입 통신 성공")
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
