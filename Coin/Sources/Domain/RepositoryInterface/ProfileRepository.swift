//
//  ProfileRepository.swift
//  Coin
//
//  Created by gnksbm on 8/22/24.
//

import Foundation

import RxSwift

protocol ProfileRepository {
    func readMyProfile(request: ReadMyProfileRequest) -> Single<ProfileResponse>
    func updateProfile(request: UpdateProfileRequest) -> Single<ProfileResponse>
}
