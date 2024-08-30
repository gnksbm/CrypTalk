//
//  ReuseIdentifiable.swift
//
//
//  Created by gnksbm on 8/30/24.
//

#if canImport(UIKit)
import UIKit

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String { String(describing: Self.self) }
}

extension NSObject: ReuseIdentifiable { }

public extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(
        cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        dequeueReusableCell(
            withIdentifier: cellType.identifier,
            for: indexPath
        ) as! T
    }
}
#endif
