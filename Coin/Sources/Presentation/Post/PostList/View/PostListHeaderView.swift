//
//  PostListHeaderView.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Kingfisher
import Neat
import RxCocoa

final class PostListHeaderView: BaseView {
    lazy var titleTapEvent = titleButton.rx.tap
    private let iconImageView = UIImageView().nt.configure {
        $0.contentMode(.scaleAspectFill)
            .layer.cornerRadius(Design.Dimension.symbolSize / 2)
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
            .configuration.imagePadding(Design.Padding.regular)
    }
    private let priceLabel = UILabel().nt.configure {
        $0.textColor(Design.Color.foreground)
            .textAlignment(.right)
            .font(.systemFont(ofSize: 24, weight: .medium))
    }
    private let rateLabel = UILabel().nt.configure {
        $0.textColor(Design.Color.foreground)
            .textAlignment(.right)
            .font(.systemFont(ofSize: 20, weight: .bold))
    }
    
    func updateView(response: CryptoCurrencyResponse) {
        iconImageView.kf.setImage(with: response.imageURL)
        titleButton.configuration?.attributedTitle = AttributedString(
            response.name,
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 26, weight: .medium),
            ])
        )
        priceLabel.text = response.price.formatted() + "원"
        rateLabel.text = response.rateToString
        rateLabel.textColor = response.rate.toForegroundColorForNumeric
    }
    
    override func configureLayout() {
        [
            iconImageView,
            titleButton,
            priceLabel,
            rateLabel
        ].forEach { addSubview($0) }
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        titleButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing)
//                .offset(Design.Padding.regular)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleButton)
            make.leading.greaterThanOrEqualTo(titleButton.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(self)
                .inset(Design.Padding.regular)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(priceLabel)
            make.bottom.equalTo(self)
                .inset(Design.Padding.regular)
        }
    }
}
