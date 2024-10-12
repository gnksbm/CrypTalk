//
//  PostListCoinCell.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import SwiftUI

import CoinFoundation
import Domain

import Kingfisher
import Neat
import RxCocoa
import RxSwift

final class PostListCoinCell: BaseTVCell {
    lazy var titleTapEvent = titleButton.rx.tap
    var disposeBag = DisposeBag()
    
    private let lineChartViewModel = LineChartViewModel()
    
    private let cardBackgroundView: UIView = {
        let view = UIView()
//        view.backgroundColor = Design.Color.foreground.withAlphaComponent(0.1)
        view.layer.cornerRadius = Design.Radius.regular
        view.layer.shadowColor = Design.Color.background.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let iconImageView = UIImageView().nt.configure {
        $0.contentMode(.scaleAspectFit) // AspectFill -> AspectFit으로 변경
            .layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .layer.borderWidth(1) // 아이콘 테두리 추가
            .layer.borderColor(Design.Color.lightPink.cgColor) // 테두리 색상 추가
            .clipsToBounds(true)
    }
    
    private let titleButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.titleAlignment(.leading)
            .configuration.baseForegroundColor(Design.Color.foreground)
            .setContentCompressionResistancePriority(
                .required,
                for: .horizontal
            )
            .configuration.image(Design.ImageLiteral.bottomArrow)
            .configuration.imagePlacement(.trailing)
            .configuration.imagePadding(Design.Padding.medium)
    }
    
    private let priceLabel = UILabel().nt.configure {
        $0.textColor(Design.Color.foreground) // 텍스트 색상 변경
            .textAlignment(.right)
            .font(.systemFont(ofSize: 22, weight: .semibold)) // 폰트 사이즈와 굵기 변경
    }
    
    private let rateLabel = UILabel().nt.configure {
        $0.textColor(Design.Color.foreground) // 텍스트 색상 변경
            .textAlignment(.left) // 텍스트 정렬을 왼쪽으로 변경
            .font(.systemFont(ofSize: 18, weight: .medium)) // 폰트 크기와 굵기 조정
    }
    
    private lazy var chartVC = {
        let chartVC = LineChartView(viewModel: lineChartViewModel).toUIKitVC
        chartVC.view.backgroundColor = .clear
        return chartVC
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        backgroundColor = Design.Color.background
    }
    
    override func configureLayout() {
        contentView.addSubview(cardBackgroundView)
        [
            iconImageView,
            titleButton,
            priceLabel,
            rateLabel,
            chartVC.view
        ].forEach { cardBackgroundView.addSubview($0) }
        
        cardBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
                .inset(Design.Padding.small)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        titleButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing)
                .offset(Design.Padding.medium) // 패딩 조정
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleButton)
            make.leading.greaterThanOrEqualTo(titleButton.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
                .offset(Design.Padding.medium).priority(.required)
            make.trailing.equalTo(priceLabel)
        }
        
        chartVC.view.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.leading.equalTo(iconImageView)
            make.trailing.equalTo(rateLabel)
            make.height.equalTo(Design.Dimension.coinChartHeight)
            make.bottom.equalTo(cardBackgroundView).inset(Design.Padding.medium)
        }
    }
    
    func configureCell(coin: PostListHeaderCellItem) {
        iconImageView.kf.setImage(with: coin.info.imageURL)
        titleButton.configuration?.attributedTitle = AttributedString(
            coin.info.name,
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 26, weight: .medium),
            ])
        )
        priceLabel.text = coin.info.price.formatted() + "원"
        rateLabel.text = coin.info.rateToString
        rateLabel.textColor = coin.info.rate.toForegroundColorForNumeric
        lineChartViewModel.chartDatas = coin.charts
    }
}
