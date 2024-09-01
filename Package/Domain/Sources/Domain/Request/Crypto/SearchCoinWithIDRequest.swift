//
//  File.swift
//  
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

public struct SearchCoinWithIDRequest {
    let searchTerm: String
    
    public init(query: String) {
        self.searchTerm = query
    }
}

extension SearchCoinWithIDRequest: QueryProvider {
    public var query: Query {
        Query(query: searchTerm)
    }
    
    public struct Query: Encodable {
        let query: String
    }
}
