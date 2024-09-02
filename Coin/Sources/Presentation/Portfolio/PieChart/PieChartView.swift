//
//  PieChartView.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import SwiftUI
import Charts

import CoinFoundation
import Domain

struct PieChartView: View {
    @StateObject var viewModel: PieChartViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    switch viewModel.state.portfolio {
                    case .loading:
                        Text("포트폴리오를 불러오는중입니다...")
                    case .empty:
                        Text("포트폴리오가 비었습니다")
                    case .loaded(let assets):
                        Group {
                            if #available(iOS 17, *) {
                                chartView(assets: assets)
                            } else {
                                Text("차트는 iOS 17 이상에서 사용 가능 합니다")
                            }
                        }
                        .padding(.bottom)
                        listView(assets: assets)
                    }
                }
            }
            .padding()
        }
    }
    
    @available(iOS 17, *)
    private func chartView(assets: [CryptoAsset]) -> some View {
        Chart {
            ForEach(assets) { asset in
                SectorMark(
                    angle: .value(
                        "Weight",
                        asset.value.price * asset.value.amount
                    ),
                    angularInset: 2.0
                )
                .annotation(position: .overlay) {
                    Text(asset.value.name)
                }
                .foregroundStyle(
                    by: .value(
                        "name",
                        asset.value.name
                    )
                )
            }
        }
        .frame(height: UIScreen.main.bounds.width)
    }
    
    private func listView(assets: [CryptoAsset]) -> some View {
        ForEach(assets) { asset in
            HStack {
                Text(asset.value.name)
                    .padding(.leading)
                Spacer()
                Text("\(asset.value.amount.removeDecimal)개")
                    .padding(.trailing)
            }
            .padding(.vertical)
        }
        .background(.tertiary)
        .clipShape(
            RoundedRectangle(cornerRadius: Design.Radius.regular)
        )
    }
    
    init(viewModel: PieChartViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    PieChartView(viewModel: PieChartViewModel())
}
