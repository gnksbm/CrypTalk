//
//  ProfileResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct ProfileResponse {
    let id: String
    let email: String
    let nickname: String
    let phoneNumber: String?
    let birthDay: String?
    let profileImagePath: String?
    let followers: [User]
    let followings: [User]
    let postIDs: [String]

    public init(
        id: String,
        email: String,
        nickname: String,
        phoneNumber: String?,
        birthDay: String?,
        profileImagePath: String?,
        followers: [User],
        followings: [User],
        postIDs: [String]
    ) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.phoneNumber = phoneNumber
        self.birthDay = birthDay
        self.profileImagePath = profileImagePath
        self.followers = followers
        self.followings = followings
        self.postIDs = postIDs
    }
}
