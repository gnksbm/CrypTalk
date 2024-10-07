//
//  PostListTableView.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import RxSwift

final class PostListTableView: ModernTableView<PostListSection, PostListItem> {
    let titleTapEvent = PublishSubject<Void>()
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let commentButtonTapEvent = PublishSubject<PostResponse>()
    
    override func createCellProvider() -> CellProvider {
        { [weak self] tableView, indexPath, item in
            guard let self else { return PostListTVCell() }
            switch item {
            case .coin(let coin):
                let cell = tableView.dequeueReusableCell(
                    cellType: PostListCoinCell.self,
                    for: indexPath
                )
                cell.configureCell(coin: coin)
                cell.disposeBag.insert {
                    cell.titleTapEvent
                        .bind(to: self.titleTapEvent)
                }
                return cell
            case .post(let item):
                let cell = tableView.dequeueReusableCell(
                    cellType: PostListTVCell.self,
                    for: indexPath
                )
                cell.configureCell(item: item)
                cell.disposeBag.insert {
                    cell.likeButtonTapEvent
                        .bind(to: self.likeButtonTapEvent)
                    
                    cell.commentButtonTapEvent
                        .bind(to: self.commentButtonTapEvent)
                }
                return cell
            }
        }
    }
}

enum PostListSection: CaseIterable {
    case header, post
}

enum PostListItem: Hashable {
    case coin(CryptoCurrencyResponse), post(PostResponse)
}
