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
            .backgroundColor(Design.Color.gray)
            .setContentCompressionResistancePriority(
                .required,
                for: .vertical
            )
    }
    
    private let nicknameLabel = UILabel().nt.configure {
        $0.textAlignment(.left)
            .font(Design.Font.title)
            .textColor(Design.Color.foreground)
    }
    
    private let dateLabel = UILabel().nt.configure {
        $0.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        .textAlignment(.left)
        .font(Design.Font.body2)
        .textColor(Design.Color.foreground)
    }
    
    private let directionLabel = UILabel().nt.configure {
        $0.font(Design.Font.body2)
            .textColor(Design.Color.foreground)
    }
    
    private let contentLabel = UILabel().nt.configure {
        $0.numberOfLines(0)
            .font(Design.Font.body1)
            .textColor(Design.Color.foreground)
    }
    
    private let likeButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle(" 0", for: .normal)
        button.titleLabel?.font = Design.Font.caption
        button.configuration?.image = Design.ImageLiteral.heart
        button.configuration?.imagePadding = Design.Padding.extraSmall
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
    
    private let multiImageView = MultiImageScrollView()
    
    private let commentCountLabel = UILabel().nt.configure {
        $0.font(Design.Font.body2)
            .textColor(Design.Color.foreground)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureLayout() {
        [
            profileImageView,
            nicknameLabel,
            dateLabel,
            directionLabel,
            contentLabel,
            likeButton,
            multiImageView,
            commentCountLabel
        ].forEach { contentView.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
                .priority(.required)
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
            make.centerY.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.leading.greaterThanOrEqualTo(directionLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(profileImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
        
        multiImageView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.equalTo(contentView)
                .inset(Design.Padding.medium)
            make.height.equalTo(0)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentLabel)
            make.top.equalTo(multiImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.bottom.equalTo(contentView).inset(Design.Padding.regular)
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
        likeButton.configuration?.title = item.likerIDs.count.formatted()
        likeButton.configuration?.imageColorTransformer = UIConfigurationColorTransformer { color in
            item.isLikedPost ?
            Design.Color.red : Design.Color.foreground
        }
        multiImageView.updateView(with: item.imageURLs)
        multiImageView.snp.updateConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
                .offset(item.imageURLs.isEmpty ? 0 : Design.Padding.regular)
            make.height.equalTo(item.imageURLs.isEmpty ? 0 : bounds.width * 0.8)
        }
        commentCountLabel.text = "댓글 \(item.comments.count)"
        let tapGesture = UITapGestureRecognizer()
        nicknameLabel.addGestureRecognizer(tapGesture)
        disposeBag.insert {
            likeButton.rx.tap
                .map { _ in item }
                .bind(to: likeButtonTapEvent)
            
            tapGesture.rx.event
                .map { _ in item.writter }
                .bind(to: nicknameButtonTapEvent)
        }
    }
}
