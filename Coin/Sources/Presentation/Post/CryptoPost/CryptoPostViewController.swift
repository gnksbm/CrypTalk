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
                plusButtonTapEvent: plusButton.rx.tap.asObservable()
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
                    vc.tableView.applyItem(items: items)
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
