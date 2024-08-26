//
//  CryptoPostUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

protocol CryptoPostUseCase {
    func fetchPosts(
        cryptoName: String,
        page: Int,
        limit: Int
    ) -> Single<[PostResponse]>
    
    func addPost(
        direction: MarketDirection,
        content: String,
        imageData: [Data]
    ) -> Single<PostResponse>
    
    func addComment(
        postID: String,
        content: String
    ) -> Single<CommentResponse>
    
    func updateComment(
        postID: String,
        commentID: String,
        content: String
    ) -> Single<CommentResponse>
    
    func deleteComment(
        postID: String,
        commentID: String
    ) -> Single<Bool>
    
    func likePost(
        postID: String,
        currentLikeStatus: Bool
    ) -> Single<UpdateLikeResponse>
}
