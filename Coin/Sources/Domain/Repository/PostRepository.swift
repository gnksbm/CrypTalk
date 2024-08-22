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
    func readPostsByHashtag(
        request: ReadPostsByHashtagRequest
    ) -> Single<[PostResponse]>
    func updatePost(request: UpdatePostRequest) -> Single<PostResponse>
    func deletePost(request: DeletePostRequest) -> Single<EmptyResponse>
}
