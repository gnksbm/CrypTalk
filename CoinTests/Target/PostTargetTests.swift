//
//  PostTargetTests.swift
//  CoinTests
//
//  Created by gnksbm on 8/19/24.
//

import XCTest

@testable import Coin
@testable import Moya
@testable import RxMoya
@testable import RxSwift

final class PostTargetTests: XCTestCase {
    private let provider = MoyaProvider<PostTarget>()
    private var disposeBag = DisposeBag()
    
    private var accessToken = "1"
    
    func testUploadImage() { 
        guard let data = UIImage(systemName: "person")?
            .jpegData(compressionQuality: 1) else { return }
        testTarget(
            .uploadImage(
                UploadImageRequest(
                    accessToken: accessToken,
                    data: [
                        data
                    ],
                    fileType: .gif
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
    
    private func testTarget(_ target: PostTarget, successStatusCode: Int) {
        let expectation = XCTestExpectation(description: "\(target) 통신 성공")
        var statusCode: Int?
        var failureStatusCode: Int?
        provider.rx.request(target)
            .subscribe(
                onSuccess: { response in
                    if successStatusCode == response.statusCode {
                        statusCode = response.statusCode
                    } else {
                        failureStatusCode = response.statusCode
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
        XCTAssertNotNil(statusCode, "\(failureStatusCode ?? 999)")
        disposeBag = DisposeBag()
    }
}
