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

final class PostListTableView: ModernTableView<SingleSection, PostResponse> {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let commentButtonTapEvent = PublishSubject<PostResponse>()
    
    override func createCellProvider() -> CellProvider {
        { [weak self] tableView, indexPath, item in
            guard let self else { return PostListTVCell() }
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
