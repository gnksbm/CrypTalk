//
//  PostDetailViewController.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat

final class PostDetailViewController: BaseViewController, ViewType {
    private let profileImageView = UIImageView().nt.configure {
        $0.layer.cornerRadius(Design.Dimension.symbolSize / 2)
            .clipsToBounds(true)
            .backgroundColor(Design.Color.secondary)
    }
    private let nicknameLabel = UILabel()
    private let dateLabel = UILabel()
    private let directionLabel = UILabel()
    private let contentLabel = UILabel()
    private let likeButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.image(UIImage(systemName: "heart"))
            .configuration.baseForegroundColor(Design.Color.red)
    }
    
    init(viewModel: PostDetailViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: PostDetailViewModel) {
        let output = viewModel.transform(
            input: PostDetailViewModel.Input(
                viewWillAppear: viewWillAppearEvent
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.post
                .withUnretained(self)
                .bind { vc, item in
                    vc.updateView(item: item)
                }
        }
    }
    
    override func configureLayout() {
        [
            profileImageView,
            nicknameLabel,
            dateLabel,
            directionLabel,
            contentLabel,
            likeButton
        ].forEach { view.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeArea)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        nicknameLabel.snp.makeConstraints { make in
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
            make.centerY.equalTo(nicknameLabel)
                .offset(Design.Padding.small)
            make.leading.equalTo(nicknameLabel.snp.trailing)
                .offset(Design.Padding.regular)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(dateLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.equalTo(safeArea)
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
        }
    }
    
    func updateView(item: PostResponse) {
        if let path = item.writter.profileImagePath {
            profileImageView.kf.setImage(with: URL(string: path))
        }
        nicknameLabel.text = item.writter.nickname
        dateLabel.text = item.createdAt.formatted(dateFormat: .createdAtOutput)
        directionLabel.text = item.direction.toString
        directionLabel.textColor = item.direction.color
        contentLabel.text = item.content
        likeButton.configuration?.title = item.likerIDs.count.formatted()
        likeButton.configuration?.image = item.isLikedPost ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
}
