//
//  MockPostRepository.swift
//  CoinTests
//
//  Created by gnksbm on 8/26/24.
//

import Foundation

@testable import Coin
@testable import RxSwift

final class MockPostRepository<T: AnyObject>: PostRepository {
    private let bundle: T.Type
    
    init(bundle: T.Type) {
        self.bundle = bundle
    }
    
    func uploadImage(
        request: UploadImageRequest
    ) -> Single<UploadImageResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "UploadImage",
                        dtoType: UploadImageDTO.self
                    )
                    observer(.success(dto.toResponse()))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func createPost(request: CreatePostRequest) -> Single<PostResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Post",
                        dtoType: CreatePostDTO.self
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
    
    func readPosts(request: ReadPostsRequest) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "MultiPost",
                        dtoType: ReadPostsDTO.self
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
    
    func readPostWithID(
        request: ReadPostWithIDRequest
    ) -> Single<PostResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Post",
                        dtoType: ReadPostWithIDDTO.self
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
    
    func readPostsByUser(
        request: ReadPostsByUserRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "MultiPost",
                        dtoType: ReadPostsByUserDTO.self
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
    
    func readPostsByHashtag(
        request: ReadPostsByHashtagRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "MultiPost",
                        dtoType: ReadPostsByHashtagDTO.self
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
    
    func readLikedPosts(
        request: ReadLikedPostsRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "MultiPost",
                        dtoType: ReadLikedPostsDTO.self
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
    
    func updatePost(request: UpdatePostRequest) -> Single<PostResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "Post",
                        dtoType: UpdatePostDTO.self
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
    
    func deletePost(request: DeletePostRequest) -> Single<EmptyResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                observer(.success(EmptyResponse()))
            }
            return Disposables.create()
        }
    }
    
    func updateLike(request: UpdateLikeRequest) -> Single<UpdateLikeResponse> {
        Single.create { observer in
            if request.accessToken == "Fail" {
                observer(.failure(BackEndError.accessTokenExpired))
            } else {
                do {
                    let dto = try fetchMockData(
                        bundle: self.bundle,
                        name: "UpdateLike",
                        dtoType: UpdateLikeDTO.self
                    )
                    observer(.success(dto.toResponse()))
                } catch {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
