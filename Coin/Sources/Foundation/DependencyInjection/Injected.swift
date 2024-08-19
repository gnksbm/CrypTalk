//
//  Injected.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

@propertyWrapper
struct Injected<T: AnyObject> {
    var wrappedValue: T {
        DIContainer.resolve(type: T.self)
    }
}
