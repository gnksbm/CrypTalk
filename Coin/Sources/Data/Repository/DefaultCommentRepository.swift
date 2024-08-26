//
//  DefaultCommentRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

final class DefaultCommentRepository: CommentRepository {
    @Injected private var networkService: NetworkService
    
    func createComment(
        request: CreateCommentRequest
    ) -> Single<CommentResponse> {
        networkService.request(
            target: CommentTarget.createComment(request),
            errorType: BackEndError.self
        )
        .decode(type: CreateCommentDTO.self)
        .map { try $0.toResponse() }
    }
    
    func updateComment(
        request: UpdateCommentRequest
    ) -> Single<CommentResponse> {
        networkService.request(
            target: CommentTarget.updateComment(request),
            errorType: BackEndError.self
        )
        .decode(type: UpdateCommentDTO.self)
        .map { try $0.toResponse() }
    }
    
    func deleteComment(request: DeleteCommentRequest) -> Single<EmptyResponse> {
        networkService.request(
            target: CommentTarget.deleteComment(request),
            errorType: BackEndError.self
        )
        .decode(type: DeleteCommentDTO.self)
    }
}
