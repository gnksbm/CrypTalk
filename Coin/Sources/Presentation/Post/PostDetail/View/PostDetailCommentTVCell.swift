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
            nicknameLabel,
            dateLabel,
            contentLabel
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
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.leading.equalTo(nicknameLabel.snp.trailing)
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
        if let urlStr = item.writter.profileImagePath {
            profileImageView.kf.setImage(with: URL(string: urlStr))
        }
        nicknameLabel.text = item.writter.nickname
        dateLabel.text = item.createdAt.relativeFormat
        contentLabel.text = item.comment
        
        let tapGesture = UITapGestureRecognizer()
        nicknameLabel.addGestureRecognizer(tapGesture)
        disposeBag.insert {
            tapGesture.rx.event
                .map { _ in item.writter }
                .bind(to: nicknameButtonTapEvent)
        }
    }
}
