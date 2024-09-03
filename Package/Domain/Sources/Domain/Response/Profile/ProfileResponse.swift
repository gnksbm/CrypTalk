//
//  ProfileResponse.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

public struct ProfileResponse {
    public let id: String
    public let email: String
    public let nickname: String
    public let phoneNumber: String?
    public let birthDay: String?
    public let profileImagePath: String?
    public let followers: [User]
    public let followings: [User]
    public let postIDs: [String]

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
