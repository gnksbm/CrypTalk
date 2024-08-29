//
//  CryptoPostHeaderView.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Kingfisher
import Neat

final class CryptoPostHeaderView: BaseView {
    private let iconImageView = UIImageView().nt.configure {
        $0.contentMode(.scaleAspectFill)
    }
    private let titleButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.titleAlignment(.leading)
            .configuration.baseForegroundColor(Design.Color.foreground)
            .setContentCompressionResistancePriority(
                .required,
                for: .horizontal
            )
    }
    private let priceLabel = UILabel().nt.configure {
        $0.textColor(Design.Color.foreground)
            .textAlignment(.right)
    }
    private let rateLabel = UILabel().nt.configure {
        $0.textColor(Design.Color.foreground)
            .textAlignment(.right)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.frame.size.height = size.height
    }
    
    func updateView(response: CryptoCurrencyResponse) {
        iconImageView.kf.setImage(with: response.imageURL)
        titleButton.configuration?.title = response.name
        priceLabel.text = response.price.formatted(.currency(code: "KRW"))
        rateLabel.text = response.rate.formatted(.percent)
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
                .inset(Design.Padding.regular).priority(.required)
            make.size.equalTo(Design.Dimension.symbolSize).priority(.required)
        }
        
        titleButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleButton)
            make.leading.equalTo(titleButton.snp.trailing)
                .offset(Design.Padding.regular).priority(.required)
            make.trailing.equalTo(self)
                .inset(Design.Padding.regular).priority(.required)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(priceLabel)
            make.bottom.equalTo(self)
                .inset(Design.Padding.regular).priority(.required)
        }
    }
}
