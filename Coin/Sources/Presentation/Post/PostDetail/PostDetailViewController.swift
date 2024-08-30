//
//  PostDetailViewController.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat



final class PostDetailViewController: BaseViewController, ViewType {
    private let headerView = PostDetailHeaderView()
    private lazy var tableView = PostDetailTableView().nt.configure {
        $0.tableHeaderView(headerView)
    }
    
    init(viewModel: PostDetailViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: PostDetailViewModel) {
        let output = viewModel.transform(
            input: PostDetailViewModel.Input(
                viewWillAppear: viewWillAppearEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.post
                .withUnretained(self)
                .bind { vc, item in
                    vc.headerView.updateView(item: item)
                }
        }
    }
    
    override func configureLayout() {
        [tableView].forEach { view.addSubview($0) }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(tableView)
        }
    }
}
