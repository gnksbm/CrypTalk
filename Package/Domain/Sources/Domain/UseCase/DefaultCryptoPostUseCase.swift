//
//  DefaultCryptoPostUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import CoinFoundation

import RxSwift
import UIKit

enum CryptoPostError: Error {
    case missingAccessToken, failureParseMarketDirection, canNotFindUserID
}

public final class DefaultCryptoPostUseCase: CryptoPostUseCase {
    @Injected private var profileRepository: ProfileRepository
    @Injected private var postRepository: PostRepository
    @Injected private var commentRepository: CommentRepository
    @Injected private var cryptoCurrencyRepository: CryptoCurrencyRepository
    
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    @UserDefaultsWrapper(key: .refreshToken, defaultValue: nil)
    private var refreshToken: String?
    @UserDefaultsWrapper(key: .userID, defaultValue: nil)
    private var userID: String?
    @UserDefaultsWrapper(key: .latestViewedID, defaultValue: "bitcoin")
    private var latestViewedID: String
    
    public init() { }
    
    public func fetchCryptoCurrencies(
        page: Int
    ) -> Single<[CryptoCurrencyResponse]> {
        cryptoCurrencyRepository.readCryptoCurrencies(page: page)
    }
    
    public func fetchPost(postID: String) -> Single<PostResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        guard let userID else {
            return .error(CryptoPostError.canNotFindUserID)
        }
        return AuthRequestRetrier(
            request: ReadPostWithIDRequest(
                accessToken: accessToken,
                postID: postID
            )
        ) { request in
            self.postRepository.readPostWithID(
                request: ReadPostWithIDRequest(
                    accessToken: accessToken,
                    postID: postID
                )
            )
        }
        .execute()
        .asObservable()
        .withUnretained(self)
        .flatMap { useCase, response in
            useCase.replaceImage(
                item: response,
                accessToken: accessToken
            )
            .flatMap { response in
                useCase.replaceImages(
                    items: response.comments,
                    accessToken: accessToken
                )
                .map { comments in
                    var copy = response
                    copy.comments = comments
                    return response
                }
            }
        }
        .map {
            var copy = $0
            copy.updateLike(userID: userID)
            return copy
        }
        .asSingle()
    }
    
    public func fetchCryptoCurrency(
        coinID: String?
    ) -> Single<(CryptoCurrencyResponse, [ChartDataResponse])> {
        let coinID = coinID ?? latestViewedID
        return Observable.zip(
            cryptoCurrencyRepository.readCryptoCurrency(coinID: coinID)
                .asObservable(),
            cryptoCurrencyRepository.readChartData(coinID: coinID, days: 1)
                .asObservable()
        )
        .withUnretained(self)
        .map { useCase, response in
            useCase.latestViewedID = coinID
            return response
        }
        .asSingle()
    }
    
    public func fetchPosts(
        cryptoName: String,
        page: Int,
        limit: Int
    ) -> Single<[PostResponse]> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        guard let userID else {
            return .error(CryptoPostError.canNotFindUserID)
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
                .map { responses in
                    responses.map {
                        var copy = $0
                        copy.updateLike(userID: userID)
                        return copy
                    }
                }
        }
        .execute()
        .asObservable()
        .withUnretained(self)
        .flatMap { useCase, items in
            useCase.replaceImages(items: items, accessToken: accessToken)
        }
        .asSingle()
    }
    
    public func addPost(
        cryptoName: String,
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
                        productID: cryptoName,
                        files: response.imagePaths
                    )
                ) { request in
                    useCase.postRepository.createPost(request: request)
                }
                .execute()
            }
            .asSingle()
    }
    
    public func addComment(
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
    
    public func updateComment(
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
    
    public func deleteComment(
        postID: String,
        commentID: String
    ) -> Single<Bool> {
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
    
    public func likePost(
        post: PostResponse
    ) -> Single<PostResponse> {
        guard let accessToken else {
            return .error(CryptoPostError.missingAccessToken)
        }
        guard let userID else {
            return .error(CryptoPostError.canNotFindUserID)
        }
        return AuthRequestRetrier(
            request: UpdateLikeRequest(
                accessToken: accessToken,
                postID: post.postID,
                likeStatus: !post.isLikedPost
            )
        ) { request in
            self.postRepository.updateLike(request: request)
                .map { response in
                    var copy = post
                    let isLiked = response.likeStatus
                    let containID = copy.likerIDs.contains(userID)
                    switch (isLiked, containID) {
                    case (true, false):
                        copy.likerIDs.append(userID)
                    case (false, true):
                        copy.likerIDs = copy.likerIDs.filter { $0 == userID }
                    case (true, true), (false, false):
                        break
                    }
                    copy.isLikedPost = response.likeStatus
                    return copy
                }
        }
        .execute()
    }
    
    public func fetchChartData(
        coinID: String,
        days: Int
    ) -> Single<[ChartDataResponse]> {
        cryptoCurrencyRepository.readChartData(
            coinID: coinID,
            days: days
        )
    }
    
    private func uploadImage(imageData: [Data]) -> Single<UploadImageResponse> {
        guard !imageData.isEmpty else {
            return .just(UploadImageResponse(imagePaths: []))
        }
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
    
    private func replaceImage(
        item: PostResponse,
        accessToken: String
    ) -> Observable<PostResponse> {
        if let additionalPath = item.writter.profileImagePath {
            return profileRepository.readImage(
                request: ReadImageReuqest(
                    accessToken: accessToken,
                    additionalPath: additionalPath
                )
            )
            .asObservable()
            .map { data in
                var copy = item
                copy.writter.imageData = data
                return copy
            }
            .catchAndReturn(item)
        } else {
            return .just(item)
        }
    }
    
    private func replaceImages(
        items: [PostResponse],
        accessToken: String
    ) -> Observable<[PostResponse]> {
        Observable.zip(
            items.map { item in
                if let additionalPath = item.writter.profileImagePath {
                    return profileRepository.readImage(
                        request: ReadImageReuqest(
                            accessToken: accessToken,
                            additionalPath: additionalPath
                        )
                    )
                    .asObservable()
                    .map { data in
                        var copy = item
                        copy.writter.imageData = data
                        return copy
                    }
                    .withUnretained(self)
                    .flatMap { useCase, response in
                        useCase.replaceImages(
                            items: response.comments,
                            accessToken: accessToken
                        )
                        .map { comments in
                            var copy = response
                            copy.comments = comments
                            return response
                        }
                    }
                    .catchAndReturn(item)
                } else {
                    return .just(item)
                }
            }
        )
    }
    
    private func replaceImages(
        items: [CommentResponse],
        accessToken: String
    ) -> Observable<[CommentResponse]> {
        Observable.zip(
            items.map { item in
                if let additionalPath = item.writter.profileImagePath {
                    return profileRepository.readImage(
                        request: ReadImageReuqest(
                            accessToken: accessToken,
                            additionalPath: additionalPath
                        )
                    )
                    .asObservable()
                    .map { data in
                        var copy = item
                        copy.writter.imageData = data
                        return copy
                    }
                    .catch { error in
                        dump(error)
                        return .just(item)
                    }
                } else {
                    return .just(item)
                }
            }
        )
    }
}
