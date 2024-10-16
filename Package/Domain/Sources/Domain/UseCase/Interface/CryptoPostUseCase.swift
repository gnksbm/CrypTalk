//
//  CryptoPostUseCase.swift
//  Coin
//
//  Created by gnksbm on 8/23/24.
//

import Foundation

import RxSwift

public protocol CryptoPostUseCase {
    func fetchCryptoCurrencies(page: Int) -> Single<[CryptoCurrencyResponse]>
    
    func fetchCryptoCurrency(
        coinID: String?
    ) -> Single<(CryptoCurrencyResponse, [ChartDataResponse])> 
    
    func fetchPosts(
        cryptoName: String,
        page: Int,
        limit: Int
    ) -> Single<[PostResponse]>
    
    func fetchPost(postID: String) -> Single<PostResponse>
    
    func addPost(
        cryptoName: String,
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
        post: PostResponse
    ) -> Single<PostResponse>
    
    func fetchChartData(
        coinID: String,
        days: Int
    ) -> Single<[ChartDataResponse]>
}
