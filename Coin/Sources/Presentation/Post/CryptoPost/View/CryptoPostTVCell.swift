//
//  CryptoPostTVCell.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat
import RxCocoa
import RxSwift
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

final class CryptoPostTVCell: BaseTVCell {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let commentButtonTapEvent = PublishSubject<PostResponse>()
    var disposeBag = DisposeBag()
    
    private let cardBackgroundView = UIView().nt.configure {
        $0.layer.cornerRadius(Design.Radius.regular)
            .clipsToBounds(true)
            .backgroundColor(.quaternarySystemFill)
    }
    
    private let profileImageView = UIImageView().nt.configure {
        $0.layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .clipsToBounds(true)
            .backgroundColor(Design.Color.secondary)
    }
    private let nicknameLabel = UILabel()
    private let directionLabel = UILabel()
    private let contentLabel = UILabel().nt.configure {
        $0.numberOfLines(3)
    }
    private let likeButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.image(UIImage(systemName: "heart"))
            .configuration.baseForegroundColor(Design.Color.red)
    }
    private let commentButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.image(UIImage(systemName: "bubble.right"))
            .configuration.baseForegroundColor(Design.Color.tint)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        selectionStyle = .none
    }
    
    override func configureLayout() {
        contentView.addSubview(cardBackgroundView)
        [
            profileImageView,
            nicknameLabel,
            directionLabel,
            contentLabel,
            likeButton,
            commentButton
        ].forEach { cardBackgroundView.addSubview($0) }
        
        cardBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(cardBackgroundView)
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
            make.trailing.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
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
            make.bottom.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
    }
    
    func configureCell(item: PostResponse) {
        if let path = item.writter.profileImagePath {
            profileImageView.kf.setImage(with: URL(string: path))
        }
        nicknameLabel.text = item.writter.nickname
        directionLabel.text = item.direction.toString
        directionLabel.textColor = item.direction.color
        contentLabel.text = item.content
        likeButton.configuration?.title = item.likerIDs.count.formatted()
        commentButton.configuration?.title = item.comments.count.formatted()
        likeButton.configuration?.image = item.isLikedPost ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        disposeBag.insert {
            likeButton.rx.tap
                .map { _ in item }
                .bind(to: likeButtonTapEvent)
            
            commentButton.rx.tap
                .map { _ in item }
                .bind(to: commentButtonTapEvent)
        }
    }
}
