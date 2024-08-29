//
//  RegistrableCell.swift
//
//
//  Created by gnksbm on 8/29/24.
//

#if canImport(UIKit)
import UIKit

public protocol RegistrableCell<Item>: UICollectionViewCell {
    associatedtype Item: Hashable
    static func createRegistration(
    ) -> UICollectionView.CellRegistration<Self, Item>
}
#endif
