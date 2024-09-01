//
//  PortfolioUseCase.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import RxSwift

public protocol PortfolioUseCase {
    func fetchPortfolio() -> Single<PortfolioResponse>
    
    func fetchPortfolio(userID: String) -> Single<PortfolioResponse>
    
    func purchaseAsset(request: CryptoAsset) -> Single<CryptoAsset>
    
    func removeAsset(
        commentID: String
    ) -> Single<Bool>
}
