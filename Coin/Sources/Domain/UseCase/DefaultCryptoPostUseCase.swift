//
//  DefaultCryptoPostUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

enum CryptoPostError: Error {
    case missingAccessToken, failureParseMarketDirection
}

final class DefaultCryptoPostUseCase: CryptoPostUseCase {
    @Injected private var authRepository: AuthRepository
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
        return postRepository.readPosts(
            request: ReadPostsRequest(
                accessToken: accessToken,
                next: "\(page)",
                limit: "\(limit)",
                productID: cryptoName
            )
        )
        .catch { [weak self] error in
            if let self,
               let error = error as? ReadPostsError,
               let refreshToken,
               case .tokenExpired = error {
                authRepository.refreshToken(
                    request: RefreshTokenRequest(
                        accessToken: accessToken,
                        refreshToken: refreshToken
                    )
                )
                .flatMap { response in
                    self.postRepository.readPosts(
                        request: ReadPostsRequest(
                            accessToken: response.accessToken,
                            next: "\(page)",
                            limit: "\(limit)",
                            productID: cryptoName
                        )
                    )
                }
            } else {
                .error(error)
            }
        }
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
        return postRepository.uploadImage(
            request: UploadImageRequest(
                accessToken: accessToken,
                data: imageData
            )
        )
        .asObservable()
        .withUnretained(self)
        .flatMap { useCase, response in
            useCase.postRepository.createPost(
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
            )
        }
        .asSingle()
    }
    
    func addComment(postID: String, content: String) -> Single<CommentResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return commentRepository.createComment(
            request: CreateCommentRequest(
                accessToken: accessToken,
                postID: postID,
                content: content
            )
        )
    }
    
    func updateComment(postID: String, commentID: String, content: String) -> Single<CommentResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return commentRepository.updateComment(
            request: UpdateCommentRequest(
                accessToken: accessToken,
                postID: postID,
                commentID: commentID,
                content: content
            )
        )
    }
    
    func deleteComment(postID: String, commentID: String) -> Single<Bool> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return commentRepository.deleteComment(
            request: DeleteCommentRequest(
                accessToken: accessToken,
                postID: postID,
                commentID: commentID
            )
        )
        .toResult()
    }
    
    func likePost(postID: String, currentLikeStatus: Bool) -> Single<UpdateLikeResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        return postRepository.updateLike(
            request: UpdateLikeRequest(
                accessToken: accessToken,
                postID: postID,
                likeStatus: !currentLikeStatus
            )
        )
    }
}
