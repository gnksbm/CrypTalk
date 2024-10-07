//
//  FakeProfileRepository.swift
//  
//
//  Created by gnksbm on 10/7/24.
//

import Foundation

import Domain

import RxSwift

public final class FakeProfileRepository: ProfileRepository {
    var profile = ProfileResponse(
        id: "",
        email: "",
        nickname: "",
        phoneNumber: "",
        birthDay: "",
        profileImagePath: "",
        followers: [],
        followings: [],
        postIDs: []
    )
    
    public init() { }
    
    public func readMyProfile(
        request: ReadMyProfileRequest
    ) -> Single<ProfileResponse> {
        .just(profile)
    }
    
    public func updateProfile(
        request: UpdateProfileRequest
    ) -> Single<ProfileResponse> {
        .just(profile)
    }
    
    public func readImage(
        request: ReadImageReuqest
    ) -> Single<Data> {
        .just(Data())
    }
}
