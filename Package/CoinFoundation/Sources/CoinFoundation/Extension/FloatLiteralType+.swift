//
//  FloatLiteralType+.swift
//  
//
//  Created by gnksbm on 9/2/24.
//

import Foundation

public extension FloatLiteralType {
    var removeDecimal: any Numeric {
        if self == FloatLiteralType(Int(self)) {
            return Int(self)
        } else {
            return self
        }
    }
}
