//
//  PostListTVCell.swift
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
    var color: UIColor? {
        switch self {
        case .increase:
            Design.Color.red
        case .decrease:
            Design.Color.blue
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

final class PostListTVCell: BaseTVCell {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let commentButtonTapEvent = PublishSubject<PostResponse>()
    var disposeBag = DisposeBag()
    
    private let cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.lightGray.withAlphaComponent(0.1)
        view.layer.cornerRadius = Design.Radius.regular
        view.layer.shadowColor = Design.Color.background.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Design.Dimension.symbolSize / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = Design.Color.background
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Design.Font.title
        label.textColor = Design.Color.whiteForeground
        label.accessibilityLabel = "닉네임"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Design.Font.body2
        label.textColor = Design.Color.whiteForeground
        label.accessibilityLabel = "날짜"
        return label
    }()
    
    private let directionLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.body2
        label.textColor = Design.Color.whiteForeground
        label.accessibilityLabel = "방향"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 다중 라인 지원
        label.font = Design.Font.body1
        label.textColor = Design.Color.whiteForeground
        label.accessibilityLabel = "콘텐츠"
        return label
    }()
    
    private let likeButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle(" 0", for: .normal)
        button.titleLabel?.font = Design.Font.caption
        button.configuration?.baseForegroundColor = Design.Color.red
        button.configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(font: Design.Font.caption)
        button.contentHorizontalAlignment = .leading
        button.configuration?.cornerStyle = .capsule
        button.accessibilityLabel = "좋아요 버튼"
        button.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle(" 0", for: .normal) // 텍스트와 이미지 간 공백 추가
        button.configuration?.image = UIImage(systemName: "bubble.fill")
        button.configuration?.baseForegroundColor = Design.Color.whiteForeground
        button.configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(font: Design.Font.caption)
        button.contentHorizontalAlignment = .leading
        button.configuration?.cornerStyle = .capsule
        button.accessibilityLabel = "댓글 버튼"
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        contentView.backgroundColor = Design.Color.background
    }
    
    override func configureLayout() {
        contentView.addSubview(cardBackgroundView)
        [
            profileImageView,
            nicknameLabel,
            dateLabel,
            directionLabel,
            contentLabel,
            likeButton,
            commentButton
        ].forEach { cardBackgroundView.addSubview($0) }
        
        cardBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
                .inset(Design.Padding.small)
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
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.leading.equalTo(nicknameLabel.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        directionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.leading.greaterThanOrEqualTo(dateLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.leading.equalTo(profileImageView)
                .offset(Design.Padding.small)
            make.trailing.equalTo(directionLabel)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.bottom.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
            make.trailing.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(profileImageView)
        }
    }
    
    func configureCell(item: PostResponse) {
        if let data = item.writter.imageData {
            profileImageView.image = UIImage(data: data)
        }
        nicknameLabel.text = item.writter.nickname
        dateLabel.text = item.createdAt.relativeFormat
        directionLabel.text = item.direction.toString
        directionLabel.textColor = item.direction.color
        contentLabel.text = item.content
        likeButton.configuration?.title = " \(item.likerIDs.count)"
        likeButton.configuration?.image =
            item.isLikedPost ?
            UIImage(systemName: "heart.fill")?.withTintColor(.red) :
            UIImage(systemName: "heart.fill")?.withTintColor(.white)
        commentButton.setTitle(" \(item.comments.count)", for: .normal)
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
