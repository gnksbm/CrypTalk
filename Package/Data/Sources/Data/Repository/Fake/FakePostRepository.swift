//
//  FakePostRepository.swift
//
//
//  Created by gnksbm on 10/6/24.
//

import Foundation

import Domain

import RxSwift

public final class FakePostRepository: PostRepository {
    public init() { }
    
    public func uploadImage(
        request: UploadImageRequest
    ) -> Single<UploadImageResponse> {
        .never()
    }
    
    public func createPost(request: CreatePostRequest) -> Single<PostResponse> {
        .never()
    }
    
    public func readPosts(request: ReadPostsRequest) -> Single<[PostResponse]> {
        Single.create { observer in
            if let url = Bundle.main.url(
                forResource: "FakePostDTO",
                withExtension: "json"
            ) {
                do {
                    let data = try Data(contentsOf: url)
                    let result = try JSONDecoder().decode(
                        ReadPostsDTO.self,
                        from: data
                    ).toResponse()
                    observer(.success(result))
                } catch {
                    dump(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func readPostWithID(
        request: ReadPostWithIDRequest
    ) -> Single<PostResponse> {
        .never()
    }
    
    public func readPostsByUser(
        request: ReadPostsByUserRequest
    ) -> Single<[PostResponse]> {
        .never()
    }
    
    public func readPostsByHashtag(
        request: ReadPostsByHashtagRequest
    ) -> Single<[PostResponse]> {
        Single.create { observer in
            if let url = Bundle.main.url(
                forResource: "FakePostDTO",
                withExtension: "json"
            ) {
                do {
                    let data = try Data(contentsOf: url)
                    let result = try JSONDecoder().decode(
                        ReadPostsDTO.self,
                        from: data
                    ).toResponse()
                    observer(.success(result))
                } catch {
                    dump(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func readLikedPosts(
        request: ReadLikedPostsRequest
    ) -> Single<[PostResponse]> {
        .never()
    }
    
    public func updatePost(request: UpdatePostRequest) -> Single<PostResponse> {
        .never()
    }
    
    public func deletePost(
        request: DeletePostRequest
    ) -> Single<EmptyResponse> {
        .never()
    }
    
    public func updateLike(
        request: UpdateLikeRequest
    ) -> Single<UpdateLikeResponse> {
        .never()
    }
}
