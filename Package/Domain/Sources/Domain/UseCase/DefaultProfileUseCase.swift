//
//  DefaultProfileUseCase.swift
//
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import CoinFoundation

import RxSwift

enum ProfileError: Error {
    case missingAccessToken
}

public final class DefaultProfileUseCase: ProfileUseCase {
    @Injected private var profileRepository: ProfileRepository
    @UserDefaultsWrapper(key: .accessToken, defaultValue: nil)
    private var accessToken: String?
    
    public init() { }
    
    public func fetchProfile() -> Single<ProfileResponse> {
        guard let accessToken else {
            return .error(ProfileError.missingAccessToken)
        }
        return profileRepository.readMyProfile(
            request: ReadMyProfileRequest(
                accessToken: accessToken
            )
        )
    }
    
    public func fetchImage(additionalPath: String) -> Single<Data> {
        guard let accessToken else {
            return .error(ProfileError.missingAccessToken)
        }
        return profileRepository.readImage(
            request: ReadImageReuqest(
                accessToken: accessToken,
                additionalPath: additionalPath
            )
        )
    }
    
    public func updateProfile(
        nick: String?,
        phoneNum: String?,
        birthDay: String?,
        profile: Data?
    ) -> Single<ProfileResponse> {
        guard let accessToken else {
            return .error(ProfileError.missingAccessToken)
        }
        return profileRepository.updateProfile(
            request: UpdateProfileRequest(
                accessToken: accessToken,
                nick: nick,
                phoneNum: phoneNum,
                birthDay: birthDay,
                profile: profile
            )
        )
    }
}
