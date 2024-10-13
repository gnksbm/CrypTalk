//
//  PostRatioCell.swift
//  Coin
//
//  Created by gnksbm on 10/12/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat

final class PostRatioCell: BaseTVCell {
    private let increaseLabel = UILabel().nt.configure {
        $0.text(MarketDirection.increase.toString)
            .font(Design.Font.heading)
    }
    
    private let decreaseLabel = UILabel().nt.configure {
        $0.text(MarketDirection.decrease.toString)
            .font(Design.Font.heading)
    }
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = Design.Color.red
        progressView.trackTintColor = Design.Color.blue
        return progressView
    }()
    
    override func configureUI() {
        contentView.backgroundColor = Design.Color.background
        contentView.layer.cornerRadius = Design.Radius.large
        contentView.layer.maskedCorners = CACornerMask(
            arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        )
        contentView.clipsToBounds = true
        backgroundColor = Design.Color.clear
        layer.shadowColor = Design.Color.foreground.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    override func configureLayout() {
        [
            increaseLabel,
            decreaseLabel,
            progressView
        ].forEach {
            contentView.addSubview($0)
        }
        
        progressView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
                .inset(Design.Padding.regular)
            make.height.equalTo(Design.Dimension.progressViewHeight)
        }
        
        increaseLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(Design.Padding.regular)
            make.leading.equalTo(progressView).inset(Design.Padding.regular)
            make.bottom.equalTo(progressView.snp.top)
                .offset(-Design.Padding.regular)
        }
        
        decreaseLabel.snp.makeConstraints { make in
            make.centerY.equalTo(increaseLabel)
            make.trailing.equalTo(progressView).inset(Design.Padding.regular)
        }
    }
    
    func configureCell(items: [PostResponse]) {
        let increaseItems = items.filter { $0.direction == .increase }
        let decreaseItems = items.filter { $0.direction == .decrease }
        increaseLabel.text =
        "\(MarketDirection.increase.toString) \(increaseItems.count)"
        decreaseLabel.text =
        "\(MarketDirection.decrease.toString) \(decreaseItems.count)"
        progressView.setProgress(
            Float(increaseItems.count.f / items.count.f),
            animated: false
        )
    }
}
