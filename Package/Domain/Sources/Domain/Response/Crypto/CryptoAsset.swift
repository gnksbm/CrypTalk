//
//  CryptoAsset.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

public struct CryptoAsset {
    public let commentID: String
    public var value: Value
    
    public init(
        commentID: String,
        value: Value
    ) {
        self.commentID = commentID
        self.value = value
    }
    
    public init(
        commentID: String,
        name: String,
        symbol: String,
        price: Double,
        amount: Double
    ) {
        self.commentID = commentID
        self.value = Value(
            name: name,
            symbol: symbol,
            price: price,
            amount: amount
        )
    }
    
    public struct Value: Codable {
        public let name: String
        public let symbol: String
        public let price: Double
        public var amount: Double
    }
}

extension CryptoAsset: Identifiable {
    public var id: String { value.name }
}
