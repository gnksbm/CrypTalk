//
//  ProfileUseCase.swift
//
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import RxSwift

public protocol ProfileUseCase {
    func fetchProfile() -> Single<ProfileResponse>
    
    func fetchImage(additionalPath: String) -> Single<Data>
    
    func updateProfile(
        nick: String?,
        phoneNum: String?,
        birthDay: String?,
        profile: Data?
    ) -> Single<ProfileResponse>
}
