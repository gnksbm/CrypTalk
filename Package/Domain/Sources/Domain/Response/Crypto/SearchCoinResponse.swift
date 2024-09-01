//
//  SearchCoinResponse.swift
//  
//
//  Created by gnksbm on 9/1/24.
//

import Foundation

public struct SearchCoinResponse: Hashable {
    public let id: String
    public let name: String
    public let iconURL: URL?
    
    public init(
        id: String,
        name: String,
        iconURL: String
    ) {
        self.id = id
        self.name = name
        self.iconURL = URL(string: iconURL)
    }
}
