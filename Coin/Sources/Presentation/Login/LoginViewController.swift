//
//  LoginViewController.swift
//  Coin
//
//  Created by gnksbm on 8/30/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat
import SnapKit
import RxCocoa

final class LoginViewController: BaseViewController, ViewType {
    private let emailTextField = UITextField().nt.configure {
        $0.borderStyle(.bezel)
            .placeholder("이메일을 입력해주세요")
    }
    private let passwordTextField = UITextField().nt.configure {
        $0.borderStyle(.bezel)
            .placeholder("비밀번호를 입력해주세요")
    }
    private let doneButton = UIButton.largeBorderedButton(title: "확인")
    
    init(viewModel: LoginViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: LoginViewModel) {
        let output = viewModel.transform(
            input: LoginViewModel.Input(
                emailChangeEvent: emailTextField.rx.text.orEmpty.asObservable(),
                passwordChangeEvent: passwordTextField.rx.text.orEmpty
                    .asObservable(),
                doneButtonTapEvent: doneButton.rx.tap.map { _ in }
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.loginResult
                .withUnretained(self)
                .bind { vc, _ in
                    let rootViewController = CryptoPostViewController(
                        viewModel: CryptoPostViewModel(
                            useCase: DefaultCryptoPostUseCase()
                        )
                    )
                    vc.view.window?.rootViewController = rootViewController
                }
        }
    }
    
    override func configureLayout() {
        [
            emailTextField,
            passwordTextField,
            doneButton
        ].forEach { view.addSubview($0) }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea).inset(Design.Padding.regular)
            make.bottom.equalTo(safeArea.snp.centerY)
                .inset(Design.Padding.regular)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(emailTextField)
            make.top.equalTo(safeArea.snp.centerY)
                .offset(Design.Padding.regular)
        }
        
        doneButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(emailTextField)
            make.bottom.equalTo(safeArea).inset(Design.Padding.regular)
        }
    }
}
