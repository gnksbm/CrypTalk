//
//  PieChartView.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import SwiftUI
import Charts

struct PieChartView: View {
    @StateObject var viewModel: PieChartViewModel
    
    var body: some View {
        if viewModel.state.portfolio.assets.isEmpty {
            Text("포트폴리오가 비었습니다")
        } else {
            if #available(iOS 17, *) {
                chartView
            } else {
                Text("iOS 17 이상에서 사용 가능 합니다")
            }
        }
    }
    
    @available(iOS 17, *)
    var chartView: some View {
        Chart {
            ForEach(viewModel.state.portfolio.assets) { asset in
                SectorMark(
                    angle: .value("Weight", asset.amount * asset.amount)
                )
            }
        }
    }
    
    init(viewModel: PieChartViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    PieChartView(viewModel: PieChartViewModel())
}
