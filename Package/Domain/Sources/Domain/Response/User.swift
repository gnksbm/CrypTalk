//
//  User.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct User: Hashable {
    public let id: String
    public let nickname: String
    public let profileImagePath: String?
    
    public init(id: String, nickname: String, profileImagePath: String?) {
        self.id = id
        self.nickname = nickname
        self.profileImagePath = profileImagePath
    }
}
