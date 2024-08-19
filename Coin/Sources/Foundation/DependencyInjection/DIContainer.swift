//
//  DIContainer.swift
//  Coin
//
//  Created by gnksbm on 8/19/24.
//

import Foundation

enum DIContainer {
    static var storage = [String: AnyObject]()
    
    static func register<T: AnyObject>(type: T.Type, object: T) {
        storage["\(type)"] = object
    }
    
    static func resolve<T: AnyObject>(type: T.Type) -> T {
        guard let object = storage["\(type)"] as? T else {
            fatalError("등록되지 않은 객체 호출: \(type)")
        }
        return object
    }
}
