//
//  ReadMyProfileDTO.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

struct ReadMyProfileDTO: Decodable {
    let userID, email, nick: String
    let phoneNum, birthDay, profileImage: String?
    let followers, following: [FollowDTO]
    let posts: [String]

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick, phoneNum, birthDay, profileImage, 
             followers, following, posts
    }
}

extension ReadMyProfileDTO {
    func toResponse() -> ProfileResponse {
        ProfileResponse(
            id: userID,
            email: email,
            nickname: nick,
            phoneNumber: phoneNum,
            birthDay: birthDay,
            profileImagePath: profileImage,
            followers: followers.map { $0.toUser() },
            followings: following.map { $0.toUser() },
            postIDs: posts
        )
    }
}

typealias FollowDTO = CreatorDTO
typealias UpdateProfileDTO = ReadMyProfileDTO
