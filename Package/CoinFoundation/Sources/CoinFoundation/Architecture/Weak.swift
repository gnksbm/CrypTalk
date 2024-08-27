//
//  Weak.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

final class Weak<Object: AnyObject> {
    weak var object: Object?
    private let objectHashValue: Int
    
    init(_ object: Object) {
        self.objectHashValue = ObjectIdentifier(object).hashValue
        self.object = object
    }
}

extension Weak: Hashable {
    static func == (lhs: Weak<Object>, rhs: Weak<Object>) -> Bool {
        lhs.objectHashValue == rhs.objectHashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(objectHashValue)
    }
}
