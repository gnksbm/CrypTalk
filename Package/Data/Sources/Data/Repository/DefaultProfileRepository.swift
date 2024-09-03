//
//  DefaultProfileRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

public final class DefaultProfileRepository: ProfileRepository {
    @Injected private var networkService: NetworkService
    
    public init() { }
    
    public func readMyProfile(
        request: ReadMyProfileRequest
    ) -> Single<ProfileResponse> {
        networkService.request(
            target: ProfileTarget.readMyProfile(request),
            errorType: BackEndError.self
        )
        .decode(type: ReadMyProfileDTO.self)
        .map { $0.toResponse() }
    }
    
    public func updateProfile(
        request: UpdateProfileRequest
    ) -> Single<ProfileResponse> {
        networkService.request(
            target: ProfileTarget.updateProfile(request),
            errorType: BackEndError.self
        )
        .decode(type: UpdateProfileDTO.self)
        .map { $0.toResponse() }
    }
    
    public func readImage(request: ReadImageReuqest) -> Single<Data> {
        networkService.request(
            target: ProfileTarget.readImage(request),
            errorType: BackEndError.self
        )
    }
}
