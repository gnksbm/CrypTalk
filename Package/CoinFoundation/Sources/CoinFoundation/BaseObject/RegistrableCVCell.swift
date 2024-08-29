//
//  RegistrableCell.swift
//
//
//  Created by gnksbm on 8/29/24.
//

#if canImport(UIKit)
import UIKit

public protocol RegistrableCell: UICollectionViewCell {
    associatedtype Item: Hashable
    
    typealias CellRegistration<Item> = 
    UICollectionView.CellRegistration<Self, Item>
    
    static func createRegistration() -> CellRegistration<Item>
}
#endif
