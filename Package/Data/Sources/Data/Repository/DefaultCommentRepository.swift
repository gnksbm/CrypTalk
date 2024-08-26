//
//  DefaultCommentRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

public final class DefaultCommentRepository: CommentRepository {
    @Injected private var networkService: NetworkService
    
    public init() { }
    
    public func createComment(
        request: CreateCommentRequest
    ) -> Single<CommentResponse> {
        networkService.request(
            target: CommentTarget.createComment(request),
            errorType: BackEndError.self
        )
        .decode(type: CreateCommentDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func updateComment(
        request: UpdateCommentRequest
    ) -> Single<CommentResponse> {
        networkService.request(
            target: CommentTarget.updateComment(request),
            errorType: BackEndError.self
        )
        .decode(type: UpdateCommentDTO.self)
        .map { try $0.toResponse() }
    }
    
    public func deleteComment(
        request: DeleteCommentRequest
    ) -> Single<EmptyResponse> {
        networkService.request(
            target: CommentTarget.deleteComment(request),
            errorType: BackEndError.self
        )
        .decode(type: DeleteCommentDTO.self)
    }
}
