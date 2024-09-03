//
//  Array+.swift
//
//
//  Created by gnksbm on 9/3/24.
//

import Foundation

public extension Array {
    subscript(safe index: Index) -> Element? {
        count - 1 >= index ? self[index] : nil
    }
}
