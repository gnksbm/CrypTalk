//
//  MockCommentRepository.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

@testable import Domain
@testable import RxSwift

final class MockCommentRepository: CommentRepository {
    private let mockComment = CommentResponse(
        id: "",
        comment: "test",
        createdAt: Date(),
        writter: User(
            id: "",
            nickname: "",
            profileImagePath: ""
        )
    )
    
    func createComment(
        request: CreateCommentRequest
    ) -> Single<CommentResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(self.mockComment))
            }
            return Disposables.create()
        }
    }
    
    func updateComment(
        request: UpdateCommentRequest
    ) -> Single<CommentResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(self.mockComment))
            }
            return Disposables.create()
        }
    }
    
    func deleteComment(
        request: DeleteCommentRequest
    ) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(EmptyResponse()))
            }
            return Disposables.create()
        }
    }
}
