//
//  DIContainer.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

public enum DIContainer {
    static var storage = [String: Any]()
    
    public static func register<T>(_ value: T, type: T.Type) {
        storage["\(type)"] = value
    }
    
    public static func resolve<T>(type: T.Type) -> T {
        guard let object = storage["\(type)"] as? T else {
            fatalError("등록되지 않은 객체 호출: \(type)")
        }
        return object
    }
}

@resultBuilder
public enum DeclarativeBuilder<T> {
    public static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
