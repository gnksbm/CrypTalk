//
//  PostDetailCommentTVCell.swift
//  Coin
//
//  Created by gnksbm on 8/30/24.
//

import UIKit

import CoinFoundation
import Domain

import RxCocoa
import RxSwift

final class PostDetailCommentTVCell: BaseTVCell {
    let nicknameButtonTapEvent = PublishSubject<User>()
    var disposeBag = DisposeBag()
    
    private let profileImageView = UIImageView().nt.configure {
        $0.layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .clipsToBounds(true)
            .backgroundColor(Design.Color.secondary)
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
    private let contentLabel = UILabel().nt.configure {
        $0.numberOfLines(0)
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
            contentLabel
        ].forEach { contentView.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameButton)
            make.leading.equalTo(nicknameButton.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.bottom.equalTo(contentView)
                .inset(Design.Padding.regular)
        }
    }
    
    func configureCell(item: CommentResponse) {
        if let data = item.writter.imageData {
            profileImageView.image = UIImage(data: data)
        }
        nicknameButton.setTitle(
            item.writter.nickname,
            for: .normal
        )
        dateLabel.text = item.createdAt.formatted(dateFormat: .createdAtOutput)
        contentLabel.text = item.comment
        
        disposeBag.insert {
            nicknameButton.rx.tap
                .map { _ in item.writter }
                .bind(to: nicknameButtonTapEvent)
        }
    }
}
