//
//  ModernCollectionView.swift
//  
//
//  Created by gnksbm on 8/29/24.
//

#if canImport(UIKit)
import UIKit

import RxSwift

open class ModernCollectionView<Section: Hashable, Item: Hashable>:
    UICollectionView {
    open class func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, env in
            NSCollectionLayoutSection.list(
                using: UICollectionLayoutListConfiguration(
                    appearance: .plain
                ),
                layoutEnvironment: env
            )
        }
    }
    
    public var emptyView: UIView?
    
    public var diffableDataSource:
    UICollectionViewDiffableDataSource<Section, Item>!
    
    public init() {
        super.init(frame: .zero, collectionViewLayout: Self.createLayout())
        configureDataSource()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func createCellProvider() -> CellProvider { { _, _, _ in nil } }
    
    open func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: self,
            cellProvider: createCellProvider()
        )
    }
    
    public func getItem(
        for indexPath: IndexPath
    ) -> Item where Section: CaseIterable, Section.AllCases.Index == Int {
        let section = Section.allCases[indexPath.section]
        return diffableDataSource.snapshot(for: section).items[indexPath.row]
    }
    
    public func applyItem(
        for section: Section,
        items: [Item],
        withAnimating: Bool = true
    ) {
        if items.isEmpty {
            backgroundView = emptyView
        } else {
            backgroundView = nil
        }
        var snapshot = Snapshot()
        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems(items, toSection: section)
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    public func appendItem(
        for section: Section,
        items: [Item],
        withAnimating: Bool = true
    ) {
        var snapshot = diffableDataSource.snapshot()
        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.appendItems(items, toSection: section)
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    public func replaceItem(
        for section: Section,
        items: [Item],
        withAnimating: Bool = true
    ) {
        var snapshot = diffableDataSource.snapshot()
        if !snapshot.sectionIdentifiers.contains(section) {
            snapshot.appendSections([section])
        }
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: section))
        snapshot.appendItems(items, toSection: section)
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    public func applyItem(
        _ sectionHandler: (Section) -> [Item],
        withAnimating: Bool = true
    ) where Section: CaseIterable {
        var snapshot = Snapshot()
        Section.allCases.forEach { section in
            snapshot.appendSections([section])
            let items = sectionHandler(section)
            if items.isEmpty {
                backgroundView = emptyView
            } else {
                backgroundView = nil
            }
            snapshot.appendItems(
                items,
                toSection: section
            )
        }
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    public func appendItem(
        _ sectionHandler: (Section) -> [Item],
        withAnimating: Bool = true
    ) where Section: CaseIterable {
        var snapshot = diffableDataSource.snapshot()
        Section.allCases.forEach { section in
            if !snapshot.sectionIdentifiers.contains(section) {
                snapshot.appendSections([section])
            }
            snapshot.appendItems(
                sectionHandler(section),
                toSection: section
            )
        }
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    public func updateItems(
        _ items: [Item],
        withAnimating: Bool = true
    ) where Item: Identifiable {
        var snapshot = diffableDataSource.snapshot()
        items.forEach { newItem in
            if let oldItem = snapshot.itemIdentifiers.first(
                where: { oldItem in
                    oldItem.id == newItem.id
                }
            ),
               let section = snapshot.sectionIdentifier(
                containingItem: oldItem
            ) {
                var items = snapshot.itemIdentifiers(inSection: section)
                snapshot.deleteItems(items)
                guard let index = items.firstIndex(of: oldItem) else { return }
                items.remove(at: index)
                items.insert(newItem, at: index)
                snapshot.appendItems(items, toSection: section)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.diffableDataSource.apply(
                snapshot,
                animatingDifferences: withAnimating
            )
        }
    }
    
    // MARK: SingleSection
    public func getItem(
        for indexPath: IndexPath
    ) -> Item where Section == SingleSection {
        return diffableDataSource.snapshot(for: .main).items[indexPath.row]
    }
    
    public func applyItem(
        items: [Item],
        withAnimating: Bool = true
    ) where Section == SingleSection {
        if items.isEmpty {
            backgroundView = emptyView
        } else {
            backgroundView = nil
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    public func appendItem(
        items: [Item],
        withAnimating: Bool = true
    ) where Section == SingleSection {
        var snapshot = diffableDataSource.snapshot()
        if !snapshot.sectionIdentifiers.contains(.main) {
            snapshot.appendSections([.main])
        }
        snapshot.appendItems(items)
        diffableDataSource.apply(
            snapshot,
            animatingDifferences: withAnimating
        )
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    public typealias CellProvider =
    (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
}

public enum SingleSection {
    case main
}

public extension ModernCollectionView
where Section: CaseIterable, Section.AllCases.Index == Int {
    var tapEvent: Observable<Item>  {
        rx.itemSelected
            .withUnretained(self)
            .map { cv, indexPath in
                cv.getItem(for: indexPath)
            }
    }
}

public extension ModernCollectionView where Section == SingleSection {
    var tapEvent: Observable<Item>  {
        rx.itemSelected
            .withUnretained(self)
            .map { cv, indexPath in
                cv.getItem(for: indexPath)
            }
    }
}

#endif
