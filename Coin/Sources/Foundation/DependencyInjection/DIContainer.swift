//
//  DIContainer.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum DIContainer {
    static var storage = [String: Any]()
    
    static func register<T>(_ value: T, type: T.Type) {
        storage["\(type)"] = value
    }
    
    static func resolve<T>(type: T.Type) -> T {
        guard let object = storage["\(type)"] as? T else {
            fatalError("등록되지 않은 객체 호출: \(type)")
        }
        return object
    }
}

@resultBuilder
enum DeclarativeBuilder<T> {
    static func buildBlock(_ components: T...) -> [T] {
        components
    }
}
