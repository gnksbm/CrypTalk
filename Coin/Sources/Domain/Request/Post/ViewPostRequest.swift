//
//  ViewPostRequest.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

struct ViewPostRequest {
    let accessToken: String
    let next: String?
    let limit: String?
    let productID: String?
}

extension ViewPostRequest: QueryProvider {
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

extension ViewPostRequest: HeaderProvider {
    var header: AccessTokenHeader {
        AccessTokenHeader(accessToken: accessToken)
    }
}
