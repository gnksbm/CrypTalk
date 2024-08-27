//
//  PortfolioRepository.swift
//  
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import RxSwift

public protocol PortfolioRepository {
    func fetchPortfolio(
        request: ReadPostWithIDRequest
    ) -> Single<PortfolioResponse>
    
    func createAsset(request: CreateCommentRequest) -> Single<CryptoAsset>
    func updateAsset(request: UpdateCommentRequest) -> Single<CryptoAsset>
    func deleteAsset(request: DeleteCommentRequest) -> Single<CryptoAsset>
}
