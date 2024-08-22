//
//  DefaultProfileRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

final class DefaultProfileRepository: ProfileRepository {
    @Injected private var networkService: NetworkService
    
    func readMyProfile(
        request: ReadMyProfileRequest
    ) -> Single<ProfileResponse> {
        networkService.request(
            target: ProfileTarget.readMyProfile(request),
            errorType: ReadMyProfileError.self
        )
        .decode(type: ReadMyProfileDTO.self)
        .map { $0.toResponse() }
    }
    
    func updateProfile(
        request: UpdateProfileRequest
    ) -> Single<ProfileResponse> {
        networkService.request(
            target: ProfileTarget.updateProfile(request),
            errorType: UpdateProfileError.self
        )
        .decode(type: UpdateProfileDTO.self)
        .map { $0.toResponse() }
    }
}
