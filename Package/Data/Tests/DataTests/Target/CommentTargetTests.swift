//
//  CommentTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Data
@testable import Domain
@testable import Moya
@testable import RxSwift

final class CommentTargetTests: XCTestCase {
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
                    commentID: ""
                )
            ),
            successStatusCode: 401
        )
    }
    
    private func testTarget(_ target: CommentTarget, successStatusCode: Int) {
        let expectation = XCTestExpectation(description: "\(target) 통신 성공")
        var statusCode: Int?
        Single<Response>.create { observer in
            MoyaProvider<CommentTarget>().request(target) { result in
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
