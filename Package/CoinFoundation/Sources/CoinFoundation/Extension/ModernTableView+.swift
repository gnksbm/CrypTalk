//
//  ModernTableView+.swift
//
//
//  Created by gnksbm on 8/29/24.
//

import Foundation

import RxSwift
import RxCocoa

public extension ModernTableView
where Section: CaseIterable, Section.AllCases.Index == Int {
    var tapEvent: Observable<Item>  {
        rx.itemSelected
            .withUnretained(self)
            .map { cv, indexPath in
                cv.getItem(for: indexPath)
            }
    }
}

public extension ModernTableView where Section == SingleSection {
    var tapEvent: Observable<Item>  {
        rx.itemSelected
            .withUnretained(self)
            .map { cv, indexPath in
                cv.getItem(for: indexPath)
            }
    }
}
