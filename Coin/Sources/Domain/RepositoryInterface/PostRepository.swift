//
//  PostRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

protocol PostRepository {
    func uploadImage(request: UploadImageRequest) -> Single<UploadImageResponse>
    func createPost(request: CreatePostRequest) -> Single<PostResponse>
    func readPosts(request: ReadPostsRequest) -> Single<[PostResponse]>
    func readPostWithID(request: ReadPostWithIDRequest) -> Single<PostResponse>
    func readPostsByUser(
        request: ReadPostsByUserRequest
    ) -> Single<[PostResponse]>
    func readPostsByHashtag(
        request: ReadPostsByHashtagRequest
    ) -> Single<[PostResponse]>
    func readLikedPosts(
        request: ReadLikedPostsRequest
    ) -> Single<[PostResponse]>
    func updatePost(request: UpdatePostRequest) -> Single<PostResponse>
    func deletePost(request: DeletePostRequest) -> Single<EmptyResponse>
    func updateLike(request: UpdateLikeRequest) -> Single<UpdateLikeResponse>
}
