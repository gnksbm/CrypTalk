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
    )
    
    func addPost(
        direction: MarketDirection,
        content: String,
        imageData: [Data]
    )
    
    func addComment(
        postID: String,
        content: String
    )
    
    func updateComment(
        postID: String,
        commentID: String,
        content: String
    )
    
    func deleteComment(
        postID: String,
        commentID: String
    )
    
    func likePost(
        postID: String,
        currentLikeStatus: Bool
    )
}
