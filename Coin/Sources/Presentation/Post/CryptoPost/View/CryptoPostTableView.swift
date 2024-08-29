//
//  CryptoPostTableView.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

final class CryptoPostTableView:
    ModernTableView<SingleSection, PostResponse> {
    override func createCellProvider() -> CellProvider {
        { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: CryptoPostCVCell.self),
                for: indexPath
            ) as? CryptoPostCVCell
            cell?.configureCell(item: item)
            return cell
        }
    }
}
