//
//  PostDetailTableView.swift
//  Coin
//
//  Created by gnksbm on 8/30/24.
//

import UIKit

import CoinFoundation
import Domain

import RxSwift

final class PostDetailTableView:
    ModernTableView<PostDetailSection, PostDetailItem> {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let nicknameButtonTapEvent = PublishSubject<User>()
    
    override func createCellProvider() -> CellProvider {
        { [weak self] tableView, indexPath, item in
            guard let self else { return UITableViewCell() }
            switch item {
            case .post(let item):
                let cell = tableView.dequeueReusableCell(
                    cellType: PostDetailPostTVCell.self,
                    for: indexPath
                )
                cell.configureCell(item: item)
                cell.likeButtonTapEvent
                    .bind(to: self.likeButtonTapEvent)
                    .disposed(by: cell.disposeBag)
                cell.nicknameButtonTapEvent
                    .bind(to: self.nicknameButtonTapEvent)
                    .disposed(by: cell.disposeBag)
                return cell
            case .comment(let item):
                let cell = tableView.dequeueReusableCell(
                    cellType: PostDetailCommentTVCell.self,
                    for: indexPath
                )
                cell.configureCell(item: item)
                cell.nicknameButtonTapEvent
                    .bind(to: self.nicknameButtonTapEvent)
                    .disposed(by: cell.disposeBag)
                return cell
            }
        }
    }
}

enum PostDetailSection: CaseIterable {
    case post, comment
}

enum PostDetailItem: Hashable {
    case post(PostResponse), comment(CommentResponse)
}
