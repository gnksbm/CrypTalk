//
//  DefaultPostRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

public final class DefaultPostRepository: PostRepository {
    @Injected private var networkService: NetworkService
    
    public init() { }
    
    public func uploadImage(
        request: UploadImageRequest
    ) -> Single<UploadImageResponse> {
        networkService.request(
            target: PostTarget.uploadImage(request),
            errorType: BackEndError.self
        )
        .decode(type: UploadImageDTO.self)
        .map { $0.toResponse() }
    }
    
    public func createPost(request: CreatePostRequest) -> Single<PostResponse> {
        networkService.request(
            target: PostTarget.createPost(request),
            errorType: BackEndError.self
        )
        .decode(type: CreatePostDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func readPosts(request: ReadPostsRequest) -> Single<[PostResponse]> {
        networkService.request(
            target: PostTarget.readPosts(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadPostsDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func readPostWithID(
        request: ReadPostWithIDRequest
    ) -> Single<PostResponse> {
        networkService.request(
            target: PostTarget.readPostWithID(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadPostWithIDDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func readPostsByUser(
        request: ReadPostsByUserRequest
    ) -> Single<[PostResponse]> {
        networkService.request(
            target: PostTarget.readPostsByUser(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadPostsByHashtagDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func readPostsByHashtag(
        request: ReadPostsByHashtagRequest
    ) -> Single<[PostResponse]> {
        networkService.request(
            target: PostTarget.readPostsByHashtag(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadPostsByHashtagDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func readLikedPosts(
        request: ReadLikedPostsRequest
    ) -> Single<[PostResponse]> {
        networkService.request(
            target: PostTarget.readLikedPosts(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadLikedPostsDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func updatePost(request: UpdatePostRequest) -> Single<PostResponse> {
        networkService.request(
            target: PostTarget.updatePost(request),
            errorType: BackEndError.self
        )
        .decode(type: UpdatePostDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func deletePost(
        request: DeletePostRequest
    ) -> Single<EmptyResponse> {
        networkService.request(
            target: PostTarget.deletePost(request),
            errorType: BackEndError.self
        )
        .decode(type: EmptyResponse.self)
    }
    
    public func updateLike(
        request: UpdateLikeRequest
    ) -> Single<UpdateLikeResponse> {
        networkService.request(
            target: PostTarget.updateLike(request),
            errorType: BackEndError.self
        )
        .decode(type: UpdateLikeDTO.self)
        .map { $0.toResponse() }
    }
}
