//
//  CryptoPostViewController.swift
//  Coin
//
//  Created by gnksbm on 8/15/24.
//

import UIKit

import CoinFoundation
import Domain

import RxSwift
import SnapKit
import Neat

final class CryptoPostViewController: BaseViewController, ViewType {
    private let pageChangeEvent = BehaviorSubject(value: 0)
    
    private let plusButton = UIBarButtonItem(systemItem: .add)
    private let headerView = CryptoPostHeaderView()
    private lazy var tableView = CryptoPostTableView().nt.configure {
        $0.tableHeaderView(headerView)
            .backgroundColor(.clear)
            .register(CryptoPostCVCell.self)
            .separatorStyle(.none)
    }
    
    init(viewModel: CryptoPostViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: CryptoPostViewModel) {
        let output = viewModel.transform(
            input: CryptoPostViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent, 
                pageChangeEvent: pageChangeEvent,
                plusButtonTapEvent: plusButton.rx.tap.asObservable(),
                cellTapEvent: tableView.tapEvent,
                likeButtonTapEvent: tableView.likeButtonTapEvent,
                commentButtonTapEvent: tableView.commentButtonTapEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.cryptoCurrency
                .withUnretained(self)
                .bind { vc, response in
                    vc.headerView.updateView(response: response)
                }
            
            output.cryptoPostResponse
                .withUnretained(self)
                .bind { vc, items in
                    vc.tableView.applyItem(
                        items: items,
                        withAnimating: false
                    )
                }
            
            output.likeChanged
                .withUnretained(self)
                .bind { vc, changedResponse in
                    vc.tableView.updateItems(
                        [changedResponse],
                        withAnimating: false
                    )
                }
            
            output.startAddFlow
                .withUnretained(self)
                .bind { vc, cryptoName in
                    vc.navigationController?.pushViewController(
                        AddPostViewController(
                            viewModel: AddPostViewModel(
                                cryptoName: cryptoName,
                                cryptoPostUseCase: DefaultCryptoPostUseCase()
                            )
                        ),
                        animated: true
                    )
                }
            
            output.startDetailFlow
                .withUnretained(self)
                .bind { vc, response in
                    vc.navigationController?.pushViewController(
                        PostDetailViewController(
                            viewModel: PostDetailViewModel(response: response)
                        ),
                        animated: true
                    )
                }
            
            output.accessTokenExpired
                .withUnretained(self)
                .bind { vc, _ in
                    vc.view.window?.rootViewController = LoginViewController(
                        viewModel: LoginViewModel(
                            authUseCase: DefaultAuthUseCase()
                        )
                    )
                }
        }
    }
    
    override func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItem = plusButton
    }
}
