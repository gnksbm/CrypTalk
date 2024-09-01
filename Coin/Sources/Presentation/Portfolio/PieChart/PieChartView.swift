//
//  PieChartView.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import SwiftUI
import Charts

import CoinFoundation

struct PieChartView: View {
    @StateObject var viewModel: PieChartViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.state.portfolio.assets.isEmpty {
                    Text("포트폴리오가 비었습니다")
                } else {
                    if #available(iOS 17, *) {
                        chartView
                    } else {
                        Text("차트는 iOS 17 이상에서 사용 가능 합니다")
                    }
                }
            }
            .padding()
            ForEach(viewModel.state.portfolio.assets) { asset in
                let name = asset.value.name
                let amount = asset.value.amount.removeDecimal
                Text("\(name) - \(amount)개")
            }
        }
    }
    
    @available(iOS 17, *)
    var chartView: some View {
        Chart {
            ForEach(viewModel.state.portfolio.assets) { asset in
                SectorMark(
                    angle: .value(
                        "Weight",
                        asset.value.price * asset.value.amount
                    ),
                    angularInset: 2.0
                )
                .annotation(position: .overlay) {
                    let name = asset.value.name
                    let amount = asset.value.amount.removeDecimal
                    Text("\(name) - \(amount)개")
                }
            }
        }
        .frame(height: UIScreen.main.bounds.width)
    }
    
    init(viewModel: PieChartViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    PieChartView(viewModel: PieChartViewModel())
}
