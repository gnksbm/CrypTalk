//
//  DefaultPortfolioRepository.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

public final class DefaultPortfolioRepository: PortfolioRepository {
    @Injected private var networkService: NetworkService
    
    public init() { }
    
    public func createPortfolio(
        request: CreatePostRequest
    ) -> Single<PortfolioResponse> {
        networkService.request(
            target: PostTarget.createPost(request),
            errorType: BackEndError.self
        )
        .decode(type: CreatePostDTO.self)
        .map { try $0.toPortfolio() }
    }
    
    public func fetchPortfolio(
        request: ReadPostsRequest
    ) -> Single<PortfolioResponse> {
        networkService.request(
            target: PostTarget.readPosts(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadPostsDTO.self)
        .map { try $0.toPortfolio() }
    }
    
    public func createAsset(
        request: CreateCommentRequest
    ) -> Single<CryptoAsset> {
        networkService.request(
            target: CommentTarget.createComment(request),
            errorType: BackEndError.self
        )
        .decode(type: CreateCommentDTO.self)
        .map { try $0.toAsset() }
    }
    
    public func updateAsset(
        request: UpdateCommentRequest
    ) -> Single<CryptoAsset> {
        networkService.request(
            target: CommentTarget.updateComment(request),
            errorType: BackEndError.self
        )
        .decode(type: UpdateCommentDTO.self)
        .map { try $0.toAsset() }
    }
    
    public func deleteAsset(
        request: DeleteCommentRequest
    ) -> Single<EmptyResponse> {
        networkService.request(
            target: CommentTarget.deleteComment(request),
            errorType: BackEndError.self
        )
        .decode(type: DeleteCommentDTO.self)
    }
}
