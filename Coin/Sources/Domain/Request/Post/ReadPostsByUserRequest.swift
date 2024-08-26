//
//  ReadPostsByUserRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ReadPostsByUserRequest {
    var accessToken: String
    let userID: String
    let next: String?
    let limit: String?
    let productID: String?
}

extension ReadPostsByUserRequest: QueryProvider {
    var query: Query {
        Query(
            next: next,
            limit: limit,
            productID: productID
        )
    }
    
    struct Query: Encodable {
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

extension ReadPostsByUserRequest: AccessTokenProvider { }
