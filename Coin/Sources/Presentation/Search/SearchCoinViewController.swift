//
//  SearchCoinViewController.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import UIKit

import CoinFoundation

import RxCocoa

final class SearchCoinViewController: BaseViewController, ViewType {
    private let searchController = UISearchController()
    private let collectionView = SearchCoinCollectionView()
    
    init(viewModel: SearchCoinViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: SearchCoinViewModel) {
        let output = viewModel.transform(
            input: SearchCoinViewModel.Input(
                queryChangeEvent: searchController.searchBar.rx.text.orEmpty
                    .asObservable(),
                searchBarReturnEvent: searchController.searchBar.searchTextField
                    .rx.controlEvent(.editingDidEndOnExit).asObservable(),
                itemSelectEvent: collectionView.tapEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.searchResult
                .bind(with: self) { vc, items in
                    vc.collectionView.applyItem(items: items)
                }
            
            output.finishFlow
                .bind(with: self) { vc, viewType in
                    switch viewType {
                    case .dismiss:
                        vc.navigationController?.popViewController(
                            animated: true
                        )
                    case .next(let vc):
                        vc.navigationController?.pushViewController(
                            vc,
                            animated: true
                        )
                    }
                }
        }
    }
    
    override func configureNavigation() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func configureLayout() {
        [collectionView].forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}
