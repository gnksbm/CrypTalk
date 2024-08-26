//
//  CommentRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

public protocol CommentRepository {
    func createComment(request: CreateCommentRequest) -> Single<CommentResponse>
    func updateComment(request: UpdateCommentRequest) -> Single<CommentResponse>
    func deleteComment(request: DeleteCommentRequest) -> Single<EmptyResponse>
}
