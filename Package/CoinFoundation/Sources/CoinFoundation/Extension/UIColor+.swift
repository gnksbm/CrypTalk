//
//  UIColor+.swift
//
//
//  Created by gnksbm on 10/11/24.
//

#if canImport(SwiftUI)
import SwiftUI

public extension UIColor {
    @available(iOS 15.0, *)
    var swiftUIColor: Color { Color(uiColor: self) }
}
#endif
