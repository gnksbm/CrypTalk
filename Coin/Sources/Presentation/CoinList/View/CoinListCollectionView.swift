//
//  CoinListCollectionView.swift
//  Coin
//
//  Created by gnksbm on 9/2/24.
//

import UIKit

import CoinFoundation
import Domain

import Neat

final class CoinListCollectionView:
    ModernCollectionView<SingleSection, CryptoCurrencyResponse> {
    override class func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let minHeight =
            Design.Dimension.symbolSize + Design.Padding.regular * 2
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(minHeight)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(minHeight)
                ),
                subitems: [item]
            )
            return NSCollectionLayoutSection(group: group)
        }
    }
    override func createCellProvider() -> CellProvider {
        let registration = CoinListCVCell.createRegistration()
        return { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: item
            )
        }
    }
}

