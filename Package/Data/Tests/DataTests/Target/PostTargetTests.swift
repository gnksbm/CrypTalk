//
//  PostTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Data
@testable import Domain
@testable import Moya
@testable import RxSwift

final class PostTargetTests: XCTestCase {
    private var disposeBag = DisposeBag()
    
    private var accessToken = "1"
    
    func testUploadImage() { 
        testTarget(
            .uploadImage(
                UploadImageRequest(
                    accessToken: accessToken,
                    data: [
                        Data()
                    ]
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testCreatePost() { 
        testTarget(
            .createPost(
                CreatePostRequest(
                    accessToken: accessToken,
                    title: nil,
                    content: nil,
                    content1: nil,
                    content2: nil,
                    content3: nil,
                    content4: nil,
                    content5: nil,
                    productID: nil,
                    files: nil
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testReadPosts() {
        testTarget(
            .readPosts(
                ReadPostsRequest(
                    accessToken: accessToken,
                    next: nil,
                    limit: nil,
                    productID: nil
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testReadPostWithID() {
        testTarget(
            .readPostWithID(
                ReadPostWithIDRequest(
                    accessToken: accessToken,
                    postID: accessToken
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testUpdatePost() { 
        testTarget(
            .updatePost(
                UpdatePostRequest(
                    accessToken: accessToken,
                    postID: accessToken,
                    title: nil,
                    content: nil,
                    content1: nil,
                    content2: nil,
                    content3: nil,
                    content4: nil,
                    content5: nil,
                    productID: nil,
                    files: nil
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testDeletePost() { 
        testTarget(
            .deletePost(
                DeletePostRequest(
                    accessToken: accessToken,
                    postID: accessToken
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testReadPostsByUser() { 
        testTarget(
            .readPostsByUser(
                ReadPostsByUserRequest(
                    accessToken: accessToken,
                    userID: accessToken,
                    next: nil,
                    limit: nil,
                    productID: nil
                )
            ),
            successStatusCode: 401
        )
    }
    
    func testReadPostsByHashtag() {
        testTarget(
            .readPostsByHashtag(
                ReadPostsByHashtagRequest(
                    accessToken: accessToken
                )
            ),
            successStatusCode: 401
        )
    }
    
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
    
    private func testTarget(_ target: PostTarget, successStatusCode: Int) {
        let expectation = XCTestExpectation(description: "\(target) 통신 성공")
        var statusCode: Int?
        var failureStatusCode: Int?
        Single<Response>.create { observer in
            MoyaProvider<PostTarget>().request(target) { result in
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
        XCTAssertNotNil(statusCode, "\(failureStatusCode ?? 999)")
        disposeBag = DisposeBag()
    }
}
