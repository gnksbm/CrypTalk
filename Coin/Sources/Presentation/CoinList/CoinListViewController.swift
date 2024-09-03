//
//  CoinListViewController.swift
//  Coin
//
//  Created by gnksbm on 9/2/24.
//

import UIKit

import CoinFoundation
import Domain

import SnapKit

final class CoinListViewController: BaseViewController, ViewType { 
    let collectionView = CoinListCollectionView().nt.configure {
        $0.emptyView(
            UILabel().nt.configure {
                $0.text("목록을 가져올 수 없습니다")
                    .textAlignment(.center)
            }
        )
    }
    
    init(viewModel: CoinListViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: CoinListViewModel) {
        let output = viewModel.transform(
            input: CoinListViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent,
                itemSelected: collectionView.tapEvent,
                chartButtonTapEvent: collectionView.chartButtonTapEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.marketCap
                .bind(with: self) { vc, items in
                    vc.collectionView.applyItem(items: items)
                }
            
            output.startPostFlow
                .bind(with: self) { vc, response in
                    vc.navigationController?.pushViewController(
                        PostListViewController(
                            viewModel: PostListViewModel(
                                useCase: DefaultCryptoPostUseCase(),
                                coinID: response.id
                            )
                        ),
                        animated: true
                    )
                }
            
            output.startChartFlow
                .bind(with: self) { vc, tuple in
                    vc.present(
                        UINavigationController(
                            rootViewController: CandlestickChartViewController(
                                viewModel: CandlestickChartViewModel(
                                    title: tuple.title,
                                    items: tuple.items
                                )
                            )
                        ),
                        animated: true
                    )
                }
        }
    }
    
    override func configureLayout() {
        [collectionView].forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    override func configureNavigation() {
        navigationItem.title = Design.StringLiteral.coinTitle
    }
}
