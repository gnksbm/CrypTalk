//
//  CryptoPostUseCaseTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import XCTest

@testable import Coin
@testable import RxSwift

final class CryptoPostUseCaseTests: XCTestCase {
    var sut: CryptoPostUseCase!
    private var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        DIContainer.register(
            MockAuthRepository(bundle: Self.self),
            type: AuthRepository.self
        )
        DIContainer.register(
            MockPostRepository(bundle: Self.self),
            type: PostRepository.self
        )
        DIContainer.register(
            MockCommentRepository(bundle: Self.self),
            type: CommentRepository.self
        )
        
        sut = DefaultCryptoPostUseCase()
    }
    
    func testFetchPosts() throws {
        let expectation = XCTestExpectation(description: "fetchPosts")
        var isSuccess = false
        sut.fetchPosts(
            cryptoName: "",
            page: 0,
            limit: 0
        )
        .subscribe(
            onSuccess: { response in
                if !response.isEmpty {
                    isSuccess = true
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
        XCTAssertTrue(isSuccess)
        disposeBag = DisposeBag()
    }
    
    func testAddPost() throws {
        let expectation = XCTestExpectation(description: "addPost")
        var isSuccess = false
        let content = "123"
        sut.addPost(
            direction: .decrease,
            content: content,
            imageData: []
        )
        .subscribe(
            onSuccess: { response in
                if response.content == content {
                    isSuccess = true
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
        XCTAssertTrue(isSuccess)
        disposeBag = DisposeBag()
    }
    
    func testAddComment() throws {
        let expectation = XCTestExpectation(description: "addComment")
        var isSuccess = false
        let content = "123"
        sut.addComment(
            postID: "",
            content: content
        )
        .subscribe(
            onSuccess: { response in
                if response.comment == content {
                    isSuccess = true
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
        XCTAssertTrue(isSuccess)
        disposeBag = DisposeBag()
    }
    
    func testUpdateComment() throws {
        let expectation = XCTestExpectation(description: "updateComment")
        var isSuccess = false
        let content = "123"
        sut.updateComment(
            postID: "",
            commentID: "",
            content: content
        )
        .subscribe(
            onSuccess: { response in
                if response.comment == content {
                    isSuccess = true
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
        XCTAssertTrue(isSuccess)
        disposeBag = DisposeBag()
    }
    
    func testDeleteComment() throws {
        let expectation = XCTestExpectation(description: "deleteComment")
        var isSuccess = false
        sut.deleteComment(
            postID: "",
            commentID: ""
        )
        .subscribe(
            onSuccess: { response in
                isSuccess = true
                expectation.fulfill()
            },
            onFailure: { error in
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
        )
        .disposed(by: disposeBag)
        wait(for: [expectation])
        XCTAssertTrue(isSuccess)
        disposeBag = DisposeBag()
    }
    
    func testLikePost() throws {
        let expectation = XCTestExpectation(description: "deleteComment")
        var isSuccess = false
        sut.likePost(
            postID: "",
            currentLikeStatus: false
        )
        .subscribe(
            onSuccess: { response in
                if response.likeStatus == false {
                    isSuccess = true
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
        XCTAssertTrue(isSuccess)
        disposeBag = DisposeBag()
    }
}
