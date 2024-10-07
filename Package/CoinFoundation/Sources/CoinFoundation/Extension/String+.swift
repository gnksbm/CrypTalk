//
//  File.swift
//  
//
//  Created by gnksbm on 9/4/24.
//

#if canImport(UIKit)
import UIKit

public extension Double {
    var toForegroundColorForNumeric: UIColor? {
        switch self {
        case ..<0:
            return Design.Color.blue
        case 0:
            return Design.Color.whiteForeground
        default:
            return Design.Color.red
        }
    }
}
#endif
