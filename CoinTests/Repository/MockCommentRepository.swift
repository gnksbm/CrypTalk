//
//  MockCommentRepository.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

@testable import Coin
@testable import RxSwift

final class MockCommentRepository<T: AnyObject>: CommentRepository {
    private let bundle: T.Type
    
    init(bundle: T.Type) {
        self.bundle = bundle
    }
    
    func createComment(
        request: CreateCommentRequest
    ) -> Single<CommentResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Comment",
                        dtoType: CreateCommentDTO.self
                    )
                    let result = try dto.toResponse()
                    observer(.success(result))
                } catch {
                    observer(.failure(error))
                }
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
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Comment",
                        dtoType: UpdateCommentDTO.self
                    )
                    let result = try dto.toResponse()
                    observer(.success(result))
                } catch {
                    observer(.failure(error))
                }
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
