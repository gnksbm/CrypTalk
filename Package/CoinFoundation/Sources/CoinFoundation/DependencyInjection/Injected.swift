//
//  Injected.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T {
        DIContainer.resolve(type: T.self)
    }
    
    public init() { }
}
