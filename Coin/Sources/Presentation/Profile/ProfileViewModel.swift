//
//  ProfileViewModel.swift
//  Coin
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class ProfileViewModel: ViewModelType {
    private let profileUseCase: ProfileUseCase
    
    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            profile: PublishSubject(),
            profileImage: PublishSubject(),
            startPhotoFlow: input.imageButtonTapEvent,
            finishFlow: PublishSubject()
        )
        
        disposeBag.insert {
            let fetchedProfile = input.viewWillAppearEvent
                .withUnretained(self)
                .flatMap { vm, _ in
                    vm.profileUseCase.fetchProfile()
                }
                .catch { error in
                    Logger.error(error)
                    return .empty()
                }
                .share()
            
            fetchedProfile
                .bind(to: output.profile)
            
            fetchedProfile
                .withUnretained(self)
                .flatMap { vm, profile in
                    if let additionalPath = profile.profileImagePath {
                        return vm.profileUseCase.fetchImage(
                            additionalPath: additionalPath
                        )
                    } else {
                        return .never()
                    }
                }
                .catch { error in
                    Logger.error(error)
                    return .empty()
                }
                .bind(to: output.profileImage)
            
            input.updateButtonTapEvent
                .withLatestFrom(
                    Observable.combineLatest(
                        output.profile,
                        input.selectedImage
                    )
                )
                .withUnretained(self)
                .flatMap { vm, tuple in
                    let (profile, imageData) = tuple
                    return vm.profileUseCase.updateProfile(
                        nick: profile.nickname,
                        phoneNum: profile.phoneNumber,
                        birthDay: profile.birthDay,
                        profile: imageData
                    )
                }
                .map { _ in }
                .bind(to: output.finishFlow)
        }
        
        return output
    }
}

extension ProfileViewModel {
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let imageButtonTapEvent: Observable<Void>
        let selectedImage: Observable<Data?>
        let updateButtonTapEvent: Observable<Void>
    }
    
    struct Output {
        let profile: PublishSubject<ProfileResponse>
        let profileImage: PublishSubject<Data>
        let startPhotoFlow: Observable<Void>
        let finishFlow: PublishSubject<Void>
    }
}
