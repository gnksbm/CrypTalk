//
//  CandlestickChartView.swift
//  Coin
//
//  Created by gnksbm on 9/3/24.
//

import UIKit

import CoinFoundation
import Domain

final class CandlestickChartView: UIScrollView {
    private var dataSource: [CandlestickRepresentable] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var visibleViewDic = [Date: (body: UIView, tail: UIView)]()
    
    var appearance = Appearance()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = appearance.backgroundColor
    }
    
    init() {
        super.init(frame: .zero)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateChart(dataSource: [CandlestickRepresentable]) {
        let sortedDataSource = dataSource.sorted { $0.date < $1.date }
        self.dataSource = sortedDataSource
        let contentWidth = CGFloat(dataSource.count) * appearance.candleWidth
        contentSize = CGSize(width: contentWidth, height: bounds.height)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let chartHighest = dataSource.chartHighest,
              let chartLowest = dataSource.chartLowest
        else { return }
        
        let candleWidth = contentSize.width / dataSource.count.f
        let chartRange = (chartHighest - chartLowest) / contentSize.height
        
        let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
        let startIndex = max(Int(visibleRect.minX / candleWidth), 0)
        let endIndex = min(
            Int((visibleRect.maxX + candleWidth) / candleWidth),
            dataSource.count
        )
        
        for index in startIndex..<endIndex {
            drawCandle(
                index: index,
                chartRange: chartRange,
                candleWidth: candleWidth,
                chartHighest: chartHighest
            )
        }
    }
    
    private func drawCandle(
        index: Int,
        chartRange: CGFloat,
        candleWidth: CGFloat,
        chartHighest: CGFloat
    ) {
        let candle = dataSource[index]
        if let visibleCandle = visibleViewDic[candle.date] {
            let candleHeight
            = candle.dailyRange == 0 ? 1 : candle.dailyRange / chartRange
            if visibleCandle.body.bounds.height != candleHeight {
                visibleViewDic.removeValue(
                    forKey: candle.date
                )
                visibleCandle.body.removeFromSuperview()
                visibleCandle.tail.removeFromSuperview()
            } else {
                return
            }
        }
        
        let bodyHeight
        = candle.fluctuation == 0 ? 1 : candle.fluctuation / chartRange
        let tailHeight
        = candle.dailyRange == 0 ? 1 : candle.dailyRange / chartRange
        
        let bodyRect = CGRect(
            x: CGFloat(index) * candleWidth
            + (appearance.bodyWidthMultiplier / 2),
            y: (chartHighest - candle.openingPrice) / chartRange,
            width: candleWidth * appearance.bodyWidthMultiplier,
            height: bodyHeight
        )
        
        let tailRect = CGRect(
            x: bodyRect.minX + (bodyRect.width / 2),
            y: (chartHighest - candle.highestPrice) / chartRange,
            width: appearance.tailWidth,
            height: tailHeight
        )
        
        let candleBodyView = UIView()
        let candleTailView = UIView()
        
        [candleBodyView, candleTailView].forEach {
            $0.backgroundColor = getCandleColor(kind: candle.candleKind)
            addSubview($0)
        }
        
        visibleViewDic[candle.date] = (candleBodyView, candleTailView)
        
        candleBodyView.frame = bodyRect
        candleTailView.frame = tailRect
    }
    
    private func getCandleColor(kind: CandleKind) -> UIColor? {
        var candleColor: UIColor?
        switch kind {
        case .white:
            candleColor = appearance.whiteCandleColor
        case .dodge:
            candleColor = appearance.dodgeCandleColor
        case .black:
            candleColor = appearance.blackCandleColor
        }
        return candleColor
    }
}

extension CandlestickChartView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setNeedsDisplay()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        setNeedsDisplay()
    }
    
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        setNeedsDisplay()
    }
}

extension CandlestickChartView {
    struct Appearance {
        let tailWidth: CGFloat
        let bodyWidthMultiplier: CGFloat
        let candleWidth: CGFloat
        let whiteCandleColor: UIColor?
        let dodgeCandleColor: UIColor?
        let blackCandleColor: UIColor?
        let backgroundColor: UIColor?
        
        init(
            tailWidth: CGFloat = 1,
            bodyWidthMultiplier: CGFloat = 0.9,
            candleWidth: CGFloat = 10,
            whiteCandleColor: UIColor? = .red,
            dodgeCandleColor: UIColor? = .gray,
            blackCandleColor: UIColor? = .blue,
            backgroundColor: UIColor? = .systemBackground
        ) {
            self.tailWidth = tailWidth
            self.bodyWidthMultiplier = bodyWidthMultiplier
            self.candleWidth = candleWidth
            self.whiteCandleColor = whiteCandleColor
            self.dodgeCandleColor = dodgeCandleColor
            self.blackCandleColor = blackCandleColor
            self.backgroundColor = backgroundColor
        }
    }
}
