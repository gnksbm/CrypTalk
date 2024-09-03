//
//  CandlestickChartViewController.swift
//  Coin
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

import CoinFoundation
   
final class CandlestickChartViewController: BaseViewController, ViewType {
    private let candleChartView = CandlestickChartView().nt.configure {
        $0.appearance(
            .init(
                whiteCandleColor: Design.Color.red,
                blackCandleColor: Design.Color.tint,
                backgroundColor: Design.Color.background
            )
        )
    }
    
    init(viewModel: CandlestickChartViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: CandlestickChartViewModel) {
        let output = viewModel.transform(
            input: CandlestickChartViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent,
                viewDidAppearEvent: viewDidAppearEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.navigationTitle
                .bind(with: self) { vc, title in
                    vc.navigationItem.title = title
                }
            
            output.chartData
                .bind(with: self) { vc, items in
                    vc.candleChartView.updateChart(dataSource: items)
                }
        }
    }
    
    override func configureLayout() {
        [candleChartView].forEach {
            view.addSubview($0)
        }
        
        candleChartView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}
