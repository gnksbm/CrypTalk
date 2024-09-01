//
//  PortfolioViewController.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import UIKit
import SwiftUI

import CoinFoundation
import Domain

import SnapKit

final class PortfolioViewController: BaseViewController, ViewType {
    private let chartViewModel = PieChartViewModel()
    private lazy var chartViewController = UIHostingController(
        rootView: PieChartView(viewModel: chartViewModel)
    )
    private let purchaseButton = UIBarButtonItem(
        image: Design.ImageLiteral.addAsset
    )
    
    init(viewModel: PortfolioViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: PortfolioViewModel) {
        let output = viewModel.transform(
            input: PortfolioViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent,
                purchaseButtonTapped: purchaseButton.rx.tap.asObservable()
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.portfolio
                .bind(with: self) { vc, response in
                    vc.chartViewModel.reduce(action: .updatePortfolio(response))
                }
            
            output.startPurchaseFlow
                .bind(with: self) { vc, _ in
                    vc.navigationController?.pushViewController(
                        PurchaseCoinViewController(
                            viewModel: PurchaseCoinViewModel(
                                portfolioUseCase: DefaultPortfolioUseCase(),
                                cryptoPostUseCase: DefaultCryptoPostUseCase()
                            )
                        ),
                        animated: true
                    )
                }
        }
    }
    
    override func configureLayout() {
        [chartViewController.view].forEach {
            view.addSubview($0)
        }
        
        chartViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    override func configureNavigation() {
        navigationItem.rightBarButtonItem = purchaseButton
        navigationItem.title = Design.StringLiteral.portfolioTab
    }
}
