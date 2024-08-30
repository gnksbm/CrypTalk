//
//  CryptoPostTableView.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import RxSwift

final class CryptoPostTableView:
    ModernTableView<SingleSection, PostResponse> {
    let likeButtonTapEvent = PublishSubject<PostResponse>()
    let commentButtonTapEvent = PublishSubject<PostResponse>()
    
    override func createCellProvider() -> CellProvider {
        { [weak self] tableView, indexPath, item in
            guard let self,
                  let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CryptoPostTVCell.self),
                for: indexPath
            ) as? CryptoPostTVCell else { return CryptoPostTVCell() }
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
