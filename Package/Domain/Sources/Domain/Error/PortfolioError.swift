//
//  PortfolioError.swift
//  
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

public enum PortfolioError: Error {
    case canNotFindPortfolio, missingAccessToken, failureParseCryptoAsset,
         canNotFindUserID
}
