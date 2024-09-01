//
//  CoinListCVCell.swift
//  Coin
//
//  Created by gnksbm on 9/2/24.
//

import UIKit

import CoinFoundation
import Domain

import Kingfisher
import Neat
import SnapKit

final class CoinListCVCell: BaseCVCell, RegistrableCell {
    static func createRegistration(
    ) -> CellRegistration<CryptoCurrencyResponse> {
        CellRegistration { cell, indexPath, item in
            cell.rankLabel.text = item.marketCapRank.formatted()
            cell.iconImageView.kf.setImage(with: item.imageURL)
            cell.nameLabel.text = item.name
            cell.priceLabel.text = item.price.formatted(.currency(code: "krw"))
        }
    }
    
    private let rankLabel = UILabel()
    private let iconImageView = UIImageView().nt.configure {
        $0.layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .clipsToBounds(true)
    }
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    override func configureLayout() {
        [
            rankLabel,
            iconImageView,
            nameLabel,
            priceLabel
        ].forEach { contentView.addSubview($0) }
        
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
            make.leading.equalTo(rankLabel.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
    }
}
