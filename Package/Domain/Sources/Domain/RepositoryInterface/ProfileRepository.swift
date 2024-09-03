//
//  ProfileRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

public protocol ProfileRepository {
    func readMyProfile(request: ReadMyProfileRequest) -> Single<ProfileResponse>
    func updateProfile(request: UpdateProfileRequest) -> Single<ProfileResponse>
    func readImage(request: ReadImageReuqest) -> Single<Data>
}
