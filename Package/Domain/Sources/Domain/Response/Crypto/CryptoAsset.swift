//
//  CryptoAsset.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

public struct CryptoAsset: Codable {
    public let id: String
    public let name: String
    public let symbol: String
    public let price: Double
    public let amount: Double
}
