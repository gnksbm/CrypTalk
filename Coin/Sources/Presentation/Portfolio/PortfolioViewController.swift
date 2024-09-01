//
//  PortfolioViewController.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import UIKit
import SwiftUI

import CoinFoundation
import SnapKit

final class PortfolioViewController: BaseViewController, ViewType {
    let chartViewModel = PieChartViewModel()
    lazy var chartViewController = UIHostingController(
        rootView: PieChartView(viewModel: chartViewModel)
    )
    
    init(viewModel: PortfolioViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: PortfolioViewModel) {
        let output = viewModel.transform(
            input: PortfolioViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.portfolio
                .bind(with: self) { vc, response in
                    vc.chartViewModel.reduce(action: .updatePortfolio(response))
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
}
