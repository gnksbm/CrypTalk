//
//  LineChartView.swift
//  Coin
//
//  Created by gnksbm on 10/11/24.
//

import Charts
import SwiftUI

import CoinFoundation
import Domain

extension ChartDataResponse: Identifiable {
    public var id: Date { date }
}

final class LineChartViewModel: ObservableObject {
    @Published var chartDatas: [ChartDataResponse] = []
    
    var lowestPrice: Double {
        guard let min = chartDatas.map({ $0.closingPrice }).min()
        else { return 0 }
        return min
    }
    
    var chartRange: ClosedRange<Double> {
        let arr = chartDatas.map { $0.closingPrice }
        guard let min = arr.min(),
              let max = arr.max() else { return 0...0 }
        return min...max
    }
}

@available(iOS 16.0, *)
struct LineChartView: View {
    let color: Color
    @StateObject var viewModel: LineChartViewModel
    
    var body: some View {
        Chart(viewModel.chartDatas) {
            AreaMark(
                x: .value("Date", $0.date),
                yStart: .value("Price", viewModel.lowestPrice),
                yEnd: .value("Price", $0.closingPrice)
            )
            .foregroundStyle(
                .linearGradient(
                    colors: [
                        color,
                        .clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            LineMark(
                x: .value("Date", $0.date),
                y: .value("Price", $0.closingPrice)
            )
            .foregroundStyle(color)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .contentTransition(.interpolate)
        .clipped()
        .chartYScale(
            domain: viewModel.chartRange,
            range: .plotDimension(padding: 10)
        )
    }
    
    init(color: Color = .teal, viewModel: LineChartViewModel) {
        self.color = color
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

#if DEBUG || FAKE
import SnapKit
@available(iOS 17.0, *)
final class TestView: BaseViewController {
    @Injected var coinRepository: CryptoCurrencyRepository
    let fake: [ChartDataResponse] = [
        ChartDataResponse(
            date: 1_620_000_000, // 2021-05-04 00:00:00 +0000
            openingPrice: 82350749.0,
            highestPrice: 82418956.0,
            lowestPrice: 82329700.0,
            closingPrice: 82394337.0
        ),
        ChartDataResponse(
            date: 1_620_086_400, // 2021-05-14 00:00:00 +0000
            openingPrice: 82473080.0,
            highestPrice: 82473080.0,
            lowestPrice: 82304233.0,
            closingPrice: 82304233.0
        ),
        ChartDataResponse(
            date: 1_620_172_800, // 2021-05-24 00:00:00 +0000
            openingPrice: 82277368.0,
            highestPrice: 82277368.0,
            lowestPrice: 82119712.0,
            closingPrice: 82119712.0
        ),
        ChartDataResponse(
            date: 1_620_259_200, // 2021-06-03 00:00:00 +0000
            openingPrice: 82034569.0,
            highestPrice: 82325177.0,
            lowestPrice: 82034569.0,
            closingPrice: 82325177.0
        ),
        ChartDataResponse(
            date: 1_620_345_600, // 2021-06-13 00:00:00 +0000
            openingPrice: 82390105.0,
            highestPrice: 82390105.0,
            lowestPrice: 82057145.0,
            closingPrice: 82057145.0
        ),
        ChartDataResponse(
            date: 1_620_432_000, // 2021-06-23 00:00:00 +0000
            openingPrice: 82026570.0,
            highestPrice: 82145674.0,
            lowestPrice: 81951542.0,
            closingPrice: 81951542.0
        ),
        ChartDataResponse(
            date: 1_620_518_400, // 2021-07-03 00:00:00 +0000
            openingPrice: 81857474.0,
            highestPrice: 82168035.0,
            lowestPrice: 81857474.0,
            closingPrice: 82168035.0
        ),
        ChartDataResponse(
            date: 1_620_604_800, // 2021-07-13 00:00:00 +0000
            openingPrice: 82170307.0,
            highestPrice: 82444831.0,
            lowestPrice: 82170307.0,
            closingPrice: 82394293.0
        ),
        ChartDataResponse(
            date: 1_620_691_200, // 2021-07-23 00:00:00 +0000
            openingPrice: 82408194.0,
            highestPrice: 82449635.0,
            lowestPrice: 82334621.0,
            closingPrice: 82334621.0
        ),
        ChartDataResponse(
            date: 1_620_777_600, // 2021-08-02 00:00:00 +0000
            openingPrice: 82369115.0,
            highestPrice: 82524945.0,
            lowestPrice: 82363838.0,
            closingPrice: 82524945.0
        )
        // 추가적인 Mock 데이터는 동일한 방식으로 생성할 수 있습니다.
    ]

    let lineChartViewModel = LineChartViewModel()
    lazy var chartView = UIHostingController(rootView: LineChartView(viewModel: self.lineChartViewModel))
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartViewModel.chartDatas = fake
    }
    
    override func configureUI() {
        view.addSubview(chartView.view)
        chartView.view.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
}
@available(iOS 17.0, *)
#Preview {
    TestView()
}
#endif
