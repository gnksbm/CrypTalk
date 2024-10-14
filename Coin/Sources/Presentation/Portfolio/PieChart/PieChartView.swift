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
                    innerRadius: .ratio(0.65),
                    angularInset: 2.0
                )
                .cornerRadius(Design.Radius.regular)
                .annotation(position: .overlay, alignment: .center) {
                    Text(asset.value.name)
                        .font(Design.Font.caption)
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
            VStack(spacing: Design.Padding.regular) {
                HStack {
                    Text(asset.value.name)
                        .font(Design.Font.title)
                    Spacer()
                    Text("\(asset.value.amount.removeDecimal)개")
                }
                .padding(.horizontal)
                .padding(.top)
                HStack {
                    let ratio = CGFloat.random(in: -20...20)
                    let color = switch ratio {
                    case ..<0:
                        Design.Color.blue.swiftUIColor
                    case 0:
                        Design.Color.foreground.swiftUIColor
                    default:
                        Design.Color.red.swiftUIColor
                    }
                    Text("수익률")
                        .font(Design.Font.body1)
                    Spacer()
                    Text(String(format: "%.2f%%", ratio))
                        .foregroundStyle(color)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .font(Design.Font.body2)
        }
        .background(
            LinearGradient(
                colors: [
                    Design.Color.orangeAccent.swiftUIColor.opacity(0.3),
                    Design.Color.background.swiftUIColor
                ],
                startPoint: .center,
                endPoint: .leading
            )
//            Gradient(
//                colors: [
//                    Design.Color.orangeAccent.swiftUIColor.opacity(0.3),
//                    Design.Color.background.swiftUIColor
//                ]
//            )
        )
        .background(Design.Color.background.swiftUIColor)
        .clipShape(
            RoundedRectangle(cornerRadius: Design.Radius.regular)
        )
        .shadow(radius: 3)
        .padding(.bottom)
    }
    
    init(viewModel: PieChartViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    PieChartView(viewModel: PieChartViewModel())
}

extension View {
    func font(_ uiFont: UIFont) -> some View {
        font(Font(uiFont))
    }
}
