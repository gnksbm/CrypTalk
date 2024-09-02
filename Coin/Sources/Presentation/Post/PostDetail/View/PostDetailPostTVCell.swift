//
//  PostDetailPostTVCell.swift
//  Coin
//
//  Created by gnksbm on 8/30/24.
//

import UIKit

import CoinFoundation
import Domain

import RxCocoa
import RxSwift

final class PostDetailPostTVCell: BaseTVCell {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let nicknameButtonTapEvent = PublishSubject<User>()
    var disposeBag = DisposeBag()
    
    private let profileImageView = UIImageView().nt.configure {
        $0.layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .clipsToBounds(true)
            .backgroundColor(Design.Color.secondary)
            .setContentCompressionResistancePriority(
                .required,
                for: .vertical
            )
    }
    private let nicknameButton = UIButton().nt.configure {
        $0.setTitleColor(
            Design.Color.foreground,
            for: .normal
        )
    }
    private let dateLabel = UILabel().nt.configure {
        $0.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
    }
    private let directionLabel = UILabel()
    private let contentLabel = UILabel()
    private let likeButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.image(UIImage(systemName: "heart"))
            .configuration.baseForegroundColor(Design.Color.red)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureLayout() {
        [
            profileImageView,
            nicknameButton,
            dateLabel,
            directionLabel,
            contentLabel,
            likeButton
        ].forEach { contentView.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
                .priority(.required)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        directionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY)
                .inset(Design.Padding.small)
            make.leading.equalTo(profileImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameButton)
            make.leading.equalTo(nicknameButton.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(profileImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.leading.equalTo(profileImageView)
            make.trailing.equalTo(directionLabel)
            make.bottom.equalTo(contentView).inset(Design.Padding.regular)
        }
    }
    
    func configureCell(item: PostResponse) {
        if let path = item.writter.profileImagePath {
            profileImageView.kf.setImage(with: URL(string: path))
        }
        nicknameButton.setTitle(
            item.writter.nickname,
            for: .normal
        )
        dateLabel.text = item.createdAt.formatted(dateFormat: .createdAtOutput)
        directionLabel.text = item.direction.toString
        directionLabel.textColor = item.direction.color
        contentLabel.text = item.content
        likeButton.configuration?.title = item.likerIDs.count.formatted()
        likeButton.configuration?.image = item.isLikedPost ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        disposeBag.insert {
            likeButton.rx.tap
                .map { _ in item }
                .bind(to: likeButtonTapEvent)
            
            nicknameButton.rx.tap
                .map { _ in item.writter }
                .bind(to: nicknameButtonTapEvent)
        }
    }
}
