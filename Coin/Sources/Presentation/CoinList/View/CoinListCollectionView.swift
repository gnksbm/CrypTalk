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
import RxSwift

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
    
    let chartButtonTapEvent = PublishSubject<CryptoCurrencyResponse>()
    
    override func createCellProvider() -> CellProvider {
        let registration = CoinListCVCell.createRegistration()
        return { [weak self] collectionView, indexPath, item in
            guard let self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: item
            )
            cell.chartButtonTapEvent
                .bind(to: chartButtonTapEvent)
                .disposed(by: cell.disposeBag)
            return cell
        }
    }
}

