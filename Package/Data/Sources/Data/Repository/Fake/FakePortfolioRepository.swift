//
//  FakePortfolioRepository.swift
//
//
//  Created by gnksbm on 10/8/24.
//

import Foundation

import Domain

import RxSwift

public final class FakePortfolioRepository: PortfolioRepository {
    private var portfolioResponse = PortfolioResponse(
        portfolioID: "",
        assets: [
            CryptoAsset(
                commentID: UUID().uuidString,
                name: "비트코인",
                symbol: "btc",
                price: 88501000,
                amount: 1.54
            ),
            CryptoAsset(
                commentID: UUID().uuidString,
                name: "리플",
                symbol: "xrp",
                price: 729.7,
                amount: 53424
            ),
            CryptoAsset(
                commentID: UUID().uuidString,
                name: "이더리움",
                symbol: "eth",
                price: 3497000,
                amount: 13.299
            )
        ]
    )
    public init() { }
    
    public func createPortfolio(
        request: CreatePostRequest
    ) -> Single<PortfolioResponse> {
        .never()
    }
    
    public func fetchPortfolio(
        request: ReadPostsRequest
    ) -> Single<PortfolioResponse> {
        .just(portfolioResponse)
    }
    
    public func createAsset(
        request: CreateCommentRequest
    ) -> Single<CryptoAsset> {
        .never()
    }
    
    public func updateAsset(
        request: UpdateCommentRequest
    ) -> Single<CryptoAsset> {
        .never()
    }
    
    public func deleteAsset(
        request: DeleteCommentRequest
    ) -> Single<EmptyResponse> {
        .never()
    }
}
