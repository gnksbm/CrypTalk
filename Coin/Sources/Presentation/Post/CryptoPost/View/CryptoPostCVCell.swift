//
//  CryptoPostCVCell.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat
import SnapKit
import Kingfisher

extension MarketDirection {
    var color: UIColor {
        switch self {
        case .increase:
            Design.Color.red
        case .decrease:
            Design.Color.tint
        }
    }
    
    var toString: String {
        switch self {
        case .increase:
            "상승"
        case .decrease:
            "하락"
        }
    }
}

final class CryptoPostCVCell: BaseTVCell {
    private let profileImageView = UIImageView().nt.configure {
        $0.layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .clipsToBounds(true)
            .backgroundColor(Design.Color.secondary)
    }
    private let nicknameLabel = UILabel()
    private let directionLabel = UILabel()
    private let contentLabel = UILabel()
    private let likeButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.image(UIImage(systemName: "heart"))
            .configuration.baseForegroundColor(Design.Color.red)
    }
    private let commentButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.image(UIImage(systemName: "bubble.right"))
            .configuration.baseForegroundColor(Design.Color.tint)
    }
    
    override func configureLayout() {
        [
            profileImageView,
            nicknameLabel,
            directionLabel,
            contentLabel,
            likeButton,
            commentButton
        ].forEach { contentView.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        directionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(nicknameLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(contentView).inset(Design.Padding.regular)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.leading.equalTo(profileImageView)
            make.trailing.equalTo(directionLabel)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.bottom.equalTo(contentView).inset(Design.Padding.regular)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
    }
    
    func configureCell(item: PostResponse) {
        nicknameLabel.text = item.writter.nickname
        directionLabel.text = item.direction.toString
        contentLabel.text = item.content
        likeButton.configuration?.title = item.likerIDs.count.formatted()
        commentButton.configuration?.title = item.comments.count.formatted()
    }
}
