//
//  PortfolioResponse.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

public struct PortfolioResponse {
    public let portfolioID: String
    public let assets: [CryptoAsset]
    
    public init(
        portfolioID: String,
        assets: [CryptoAsset]
    ) {
        self.portfolioID = portfolioID
        self.assets = assets
    }
}
