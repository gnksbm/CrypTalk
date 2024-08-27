//
//  PortfolioUseCase.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import RxSwift

public protocol PortfolioUseCase {
    func fetchPortfolio(userID: String) -> Single<PortfolioResponse>
    
    func addAsset(
        userID: String,
        request: CryptoAsset
    ) -> Single<CryptoAsset>
    
    func updateAsset(
        userID: String,
        request: CryptoAsset
    ) -> Single<CryptoAsset>
    
    func removeAsset(
        userID: String,
        request: CryptoAsset
    ) -> Single<CryptoAsset>
}
