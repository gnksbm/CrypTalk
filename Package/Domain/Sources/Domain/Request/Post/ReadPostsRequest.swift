//
//  ReadPostsRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public struct ReadPostsRequest {
    public var accessToken: String
    let next: String?
    let limit: String?
    let productID: String?
    
    public init(
        accessToken: String,
        next: String?,
        limit: String?,
        productID: String?
    ) {
        self.accessToken = accessToken
        self.next = next
        self.limit = limit
        self.productID = productID
    }
}

extension ReadPostsRequest: AccessTokenProvider { }

extension ReadPostsRequest: QueryProvider {
    public var query: Query {
        Query(
            next: next,
            limit: limit,
            productID: productID
        )
    }
    
    public struct Query: Encodable {
        let next: String?
        let limit: String?
        let productID: String?
        
        enum CodingKeys: String, CodingKey {
            case next
            case limit
            case productID = "product_id"
        }
    }
}
