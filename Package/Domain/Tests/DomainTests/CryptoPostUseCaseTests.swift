//
//  CryptoPostUseCaseTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import XCTest

@testable import CoinFoundation
@testable import Domain
@testable import RxSwift

final class CryptoPostUseCaseTests: XCTestCase {
    var sut: CryptoPostUseCase!
    private var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        DIContainer.register(
            MockAuthRepository(),
            type: AuthRepository.self
        )
        DIContainer.register(
            MockPostRepository(),
            type: PostRepository.self
        )
        DIContainer.register(
            MockCommentRepository(),
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
                if response.first?.writter.nickname == "test" {
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
        sut.addPost(
            direction: .decrease,
            content: "",
            imageData: []
        )
        .subscribe(
            onSuccess: { response in
                if response.writter.nickname == "test" {
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
        sut.addComment(
            postID: "",
            content: ""
        )
        .subscribe(
            onSuccess: { response in
                if response.comment == "test" {
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
        sut.updateComment(
            postID: "",
            commentID: "",
            content: ""
        )
        .subscribe(
            onSuccess: { response in
                if response.comment == "test" {
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
