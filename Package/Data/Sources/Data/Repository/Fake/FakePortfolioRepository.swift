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
    public init() { }
    
    public func createPortfolio(
        request: CreatePostRequest
    ) -> Single<PortfolioResponse> {
        .never()
    }
    
    public func fetchPortfolio(
        request: ReadPostsRequest
    ) -> Single<PortfolioResponse> {
        .never()
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
