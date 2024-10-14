//
//  MockPostRepository.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

@testable import Domain
@testable import RxSwift

final class MockPostRepository: PostRepository {
    private let mockImage = UploadImageResponse(imagePaths: ["test"])
    private let mockPost = PostResponse(
        postID: "",
        writter: User(
            id: "",
            nickname: "test",
            profileImagePath: ""
        ),
        createdAt: Date(),
        content: "",
        direction: .decrease,
        likerIDs: [],
        comments: [],
        imageURLs: []
    )
    
    func uploadImage(
        request: UploadImageRequest
    ) -> Single<UploadImageResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(self.mockImage))
            }
            return Disposables.create()
        }
    }
    
    func createPost(request: CreatePostRequest) -> Single<PostResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(self.mockPost))
            }
            return Disposables.create()
        }
    }
    
    func readPosts(request: ReadPostsRequest) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success([self.mockPost]))
            }
            return Disposables.create()
        }
    }
    
    func readPostWithID(
        request: ReadPostWithIDRequest
    ) -> Single<PostResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(self.mockPost))
            }
            return Disposables.create()
        }
    }
    
    func readPostsByUser(
        request: ReadPostsByUserRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success([self.mockPost]))
            }
            return Disposables.create()
        }
    }
    
    func readPostsByHashtag(
        request: ReadPostsByHashtagRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success([self.mockPost]))
            }
            return Disposables.create()
        }
    }
    
    func readLikedPosts(
        request: ReadLikedPostsRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success([self.mockPost]))
            }
            return Disposables.create()
        }
    }
    
    func updatePost(request: UpdatePostRequest) -> Single<PostResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(self.mockPost))
            }
            return Disposables.create()
        }

    }
    
    func deletePost(request: DeletePostRequest) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(EmptyResponse()))
            }
            return Disposables.create()
        }
    }
    
    func updateLike(request: UpdateLikeRequest) -> Single<UpdateLikeResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(UpdateLikeResponse(likeStatus: false)))
            }
            return Disposables.create()
        }
    }
}
