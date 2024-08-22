//
//  ProfileResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

struct ProfileResponse {
    let id: String
    let email: String
    let nickname: String
    let phoneNumber: String?
    let birthDay: String?
    let profileImagePath: String?
    let followers: [User]
    let followings: [User]
    let postIDs: [String]
}
