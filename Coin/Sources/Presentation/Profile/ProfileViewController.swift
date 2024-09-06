//
//  ProfileViewController.swift
//  Coin
//
//  Created by gnksbm on 9/3/24.
//

import UIKit
import PhotosUI

import CoinFoundation
import Domain

import SnapKit
import Neat
import RxSwift

final class ProfileViewController: BaseViewController, ViewType {
    private let imageSelectedEvent = PublishSubject<Data?>()
    private let profileButton = UIButton().nt.configure {
        $0.clipsToBounds(true)
            .setImage(UIImage(systemName: "plus"), for: .normal)
    }
    private let doneButton = UIBarButtonItem(title: "완료")
    private let logoutButton = UIBarButtonItem(title: "로그아웃")
    private lazy var photoView = PHPickerViewController(
        configuration: {
            var config = PHPickerConfiguration()
            config.filter = .images
            return config
        }()
    ).nt.configure {
        $0.delegate(self)
    }
    
    init(viewModel: ProfileViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: ProfileViewModel) {
        let output = viewModel.transform(
            input: ProfileViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent,
                imageButtonTapEvent: profileButton.rx.tap.asObservable(),
                selectedImage: imageSelectedEvent.asObservable(),
                updateButtonTapEvent: doneButton.rx.tap.asObservable(), 
                logoutButtonTapEvent: logoutButton.rx.tap.asObservable()
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.profileImage
                .map { data in UIImage(data: data) }
                .bind(to: profileButton.rx.image(for: .normal))
            
            output.startPhotoFlow
                .bind(with: self) { vc, _ in
                    vc.present(
                        vc.photoView,
                        animated: true
                    )
                }
            
            output.startLoginFlow
                .bind(with: self) { vc, _ in
                    vc.view.window?.rootViewController = LoginViewController(
                        viewModel: LoginViewModel(
                            authUseCase: DefaultAuthUseCase()
                        )
                    )
                }
            
            output.finishFlow
                .bind(with: self) { vc, _ in
                    vc.navigationController?.popViewController(animated: true)
                }
            
            imageSelectedEvent
                .compactMap { $0 }
                .map { data in UIImage(data: data) }
                .bind(to: profileButton.rx.image(for: .normal))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileButton.layer.cornerRadius = profileButton.bounds.width / 2
    }
    
    override func configureUI() {
        [profileButton].forEach { view.addSubview($0) }
        
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(safeArea.snp.width).multipliedBy(0.8)
            make.center.equalTo(safeArea)
        }
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItems = [logoutButton, doneButton]
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        results.first?.itemProvider.loadObject(
            ofClass: UIImage.self
        ) { [weak self] providerReading, error in
            if let image = providerReading as? UIImage {
                self?.imageSelectedEvent.onNext(
                    image.jpegData(compressionQuality: 0.5)
                )
            }
        }
        dismiss(animated: true)
    }
}
