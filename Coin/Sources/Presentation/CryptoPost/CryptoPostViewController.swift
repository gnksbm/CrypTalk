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
    private let headerView = CryptoPostHeaderView()
    private lazy var tableView = UITableView().nt.configure {
        $0.tableHeaderView(headerView)
            .backgroundColor(.clear)
    }
    private let pageChangeEvent = BehaviorSubject(value: 1)
    
    init(viewModel: CryptoPostViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: CryptoPostViewModel) {
        let output = viewModel.transform(
            input: CryptoPostViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent, 
                pageChangeEvent: pageChangeEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.cryptoCurrency
                .withUnretained(self)
                .subscribe { vc, response in
                    vc.headerView.updateView(response: response)
                }
            
            output.cryptoPostResponse
                .withUnretained(self)
                .subscribe { vc, responses in
                    vc.headerView.updateView(responses: responses)
                }
        }
    }
    
    override func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}
