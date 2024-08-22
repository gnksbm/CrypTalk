//
//  CommentRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

protocol CommentRepository {
    func createComment(request: CreateCommentRequest) -> Single<CommentResponse>
    func updateComment(request: CreateCommentRequest) -> Single<CommentResponse>
    func deleteComment(request: CreateCommentRequest) -> Single<EmptyResponse>
}
