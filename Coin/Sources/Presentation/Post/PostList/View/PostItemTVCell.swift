//
//  PostItemTVCell.swift
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
            "매수"
        case .decrease:
            "매도"
        }
    }
}

final class PostItemTVCell: BaseTVCell {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let commentButtonTapEvent = PublishSubject<PostResponse>()
    var disposeBag = DisposeBag()
    
    private let cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.background
        view.layer.cornerRadius = Design.Radius.regular
        view.layer.shadowColor = Design.Color.foreground.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Design.Dimension.symbolSize / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = Design.Color.disable
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Design.Font.title
        label.textColor = Design.Color.foreground
        label.accessibilityLabel = "닉네임"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Design.Font.body2
        label.textColor = Design.Color.foreground
        label.accessibilityLabel = "날짜"
        return label
    }()
    
    private let directionLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.body2
        label.textColor = Design.Color.foreground
        label.accessibilityLabel = "방향"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // 다중 라인 지원
        label.font = Design.Font.body1
        label.textColor = Design.Color.foreground
        label.accessibilityLabel = "콘텐츠"
        return label
    }()
    
    private let multiImageView = MultiImageScrollView()
    
    private let likeButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle(" 0", for: .normal)
        button.titleLabel?.font = Design.Font.caption
        button.configuration?.image = Design.ImageLiteral.heart
        button.configuration?.baseForegroundColor = Design.Color.foreground
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
        button.configuration?.image = Design.ImageLiteral.chat
        button.configuration?.baseForegroundColor = Design.Color.foreground
        button.configuration?.preferredSymbolConfigurationForImage =
        UIImage.SymbolConfiguration(font: Design.Font.caption2)
        button.contentHorizontalAlignment = .leading
        button.configuration?.cornerStyle = .capsule
        button.accessibilityLabel = "댓글 버튼"
        return button
    }()
    
    private let dividerView = UIView().nt.configure {
        $0.backgroundColor(Design.Color.disable)
    }
    
    private let descriptionView = UIButton(
        configuration: .plain()
    ).nt.configure {
        $0.configuration.baseForegroundColor(Design.Color.foreground)
            .configuration.image(Design.ImageLiteral.rightArrow)
            .configuration.imagePlacement(.trailing)
            .configuration.imagePadding(Design.Padding.extraSmall)
            .configuration.preferredSymbolConfigurationForImage(
                UIImage.SymbolConfiguration(font: Design.Font.caption2)
            )
            .configuration.attributedTitle(
                AttributedString(
                    "자세히보기",
                    attributes: AttributeContainer([
                        .font: Design.Font.label
                    ])
                )
            )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        backgroundColor = Design.Color.clear
        contentView.backgroundColor = Design.Color.clear
    }
    
    override func configureLayout() {
        contentView.addSubview(cardBackgroundView)
        [
            profileImageView,
            nicknameLabel,
            dateLabel,
            directionLabel,
            contentLabel,
            multiImageView,
            likeButton,
            commentButton,
            dividerView,
            descriptionView
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
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.leading.equalTo(nicknameLabel.snp.trailing)
                .offset(Design.Padding.medium)
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
        
        multiImageView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.equalTo(cardBackgroundView)
                .inset(Design.Padding.medium)
            make.height.equalTo(0)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(multiImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(profileImageView)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom)
                .offset(Design.Padding.regular)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
                .offset(Design.Padding.small)
            make.trailing.bottom.equalTo(cardBackgroundView)
                .inset(Design.Padding.regular)
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
        multiImageView.updateView(with: item.imageURLs)
        multiImageView.snp.updateConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
                .offset(item.imageURLs.isEmpty ? 0 : Design.Padding.regular)
            make.height.equalTo(item.imageURLs.isEmpty ? 0 : bounds.width * 0.25)
        }
        likeButton.configuration?.title = " \(item.likerIDs.count)"
        likeButton.configuration?.imageColorTransformer = UIConfigurationColorTransformer { color in
            item.isLikedPost ?
            Design.Color.red : Design.Color.disable
        }
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

