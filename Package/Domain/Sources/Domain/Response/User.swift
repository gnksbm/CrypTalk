//
//  User.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct User {
    let id: String
    let nickname: String
    let profileImagePath: String?
    
    public init(id: String, nickname: String, profileImagePath: String?) {
        self.id = id
        self.nickname = nickname
        self.profileImagePath = profileImagePath
    }
}
