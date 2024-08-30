//
//  LoginViewModel.swift
//  Coin
//
//  Created by gnksbm on 8/30/24.
//

import Foundation

import CoinFoundation
import Domain

import RxSwift

final class LoginViewModel: ViewModelType {
    private let authUseCase: AuthUseCase
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output {
        let output = Output(
            loginResult: PublishSubject()
        )
        
        disposeBag.insert {
            input.doneButtonTapEvent
                .withLatestFrom(
                    Observable.combineLatest(
                        input.emailChangeEvent,
                        input.passwordChangeEvent
                    )
                )
                .withUnretained(self)
                .flatMap { vm, tuple in
                    let (email, password) = tuple
                    return vm.authUseCase.login(
                        email: email,
                        password: password
                    )
                }
                .bind(to: output.loginResult)
        }
            
        return output
    }
}

extension LoginViewModel {
    struct Input {
        let emailChangeEvent: Observable<String>
        let passwordChangeEvent: Observable<String>
        let doneButtonTapEvent: Observable<Void>
    }
    
    struct Output { 
        let loginResult: PublishSubject<Bool>
    }
}
