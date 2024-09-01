//
//  SearchCoinCollectionView.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import UIKit

import CoinFoundation
import Domain
import Kingfisher

final class SearchCoinCollectionView:
    ModernCollectionView<SingleSection, SearchCoinResponse> {
    
    override func createCellProvider() -> CellProvider {
        let registration = UICollectionView.CellRegistration
        <UICollectionViewCell, SearchCoinResponse>
        { cell, indexPath, item in
            var config = UIListContentConfiguration.cell()
            config.text = item.name
            let size = CGSize(
                width: Design.Dimension.symbolSize,
                height: Design.Dimension.symbolSize
            )
            config.imageProperties.maximumSize = size
            config.imageProperties.reservedLayoutSize = size
            cell.setImage(with: item.iconURL, config: config)
        }
        return { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: item
            )
        }
    }
}

