//
//  DefaultCryptoPostUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import CoinFoundation

import RxSwift

enum CryptoPostError: Error {
    case missingAccessToken, failureParseMarketDirection
}

final class DefaultCryptoPostUseCase: CryptoPostUseCase {
    @Injected private var postRepository: PostRepository
    @Injected private var commentRepository: CommentRepository
    
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    @UserDefaultsWrapper(key: .refreshToken, defaultValue: nil)
    private var refreshToken: String?
    
    func fetchPosts(
        cryptoName: String,
        page: Int,
        limit: Int
    ) -> Single<[PostResponse]> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: ReadPostsRequest(
                accessToken: accessToken,
                next: "\(page)",
                limit: "\(limit)",
                productID: cryptoName
            )
        ) { request in
            self.postRepository.readPosts(request: request)
        }.execute()
    }
    
    func addPost(
        direction: MarketDirection,
        content: String,
        imageData: [Data]
    ) -> Single<PostResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        guard let directionData = try? JSONEncoder().encode(direction),
              let directionStr = String(
                data: directionData,
                encoding: .utf8
        ) else { return .error(CryptoPostError.failureParseMarketDirection) }
        return uploadImage(imageData: imageData)
            .asObservable()
            .withUnretained(self)
            .flatMap { useCase, response in
                AuthRequestRetrier(
                    request: CreatePostRequest(
                        accessToken: accessToken,
                        title: nil,
                        content: content,
                        content1: directionStr,
                        content2: nil,
                        content3: nil,
                        content4: nil,
                        content5: nil,
                        productID: nil,
                        files: response.imagePaths
                    )
                ) { request in
                    useCase.postRepository.createPost(request: request)
                }.execute()
            }
            .asSingle()
    }
    
    func addComment(
        postID: String,
        content: String
    ) -> Single<CommentResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: CreateCommentRequest(
                accessToken: accessToken,
                postID: postID,
                content: content
            )
        ) { request in
            self.commentRepository.createComment(request: request)
        }
        .execute()
    }
    
    func updateComment(
        postID: String,
        commentID: String,
        content: String
    ) -> Single<CommentResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: UpdateCommentRequest(
                accessToken: accessToken,
                postID: postID,
                commentID: commentID,
                content: content
            )
        ) { request in
            self.commentRepository.updateComment(request: request)
        }
        .execute()
    }
    
    func deleteComment(postID: String, commentID: String) -> Single<Bool> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: DeleteCommentRequest(
                accessToken: accessToken,
                postID: postID,
                commentID: commentID
            )
        ) { request in
            self.commentRepository.deleteComment(request: request)
        }
        .execute()
        .toResult()
    }
    
    func likePost(
        postID: String,
        currentLikeStatus: Bool
    ) -> Single<UpdateLikeResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: UpdateLikeRequest(
                accessToken: accessToken,
                postID: postID,
                likeStatus: !currentLikeStatus
            )
        ) { request in
            self.postRepository.updateLike(request: request)
        }
        .execute()
    }
    
    private func uploadImage(imageData: [Data]) -> Single<UploadImageResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return AuthRequestRetrier(
            request: UploadImageRequest(
                accessToken: accessToken,
                data: imageData
            )
        ) { request in
            self.postRepository.uploadImage(request: request)
        }
        .execute()
    }
}
