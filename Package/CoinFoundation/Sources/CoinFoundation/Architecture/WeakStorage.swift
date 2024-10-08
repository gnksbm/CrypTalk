//
//  WeakStorage.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

struct AssociatedKey {
    static let weak = ""
}

final class WeakStorage<Key: AnyObject, Value: AnyObject> {
    private var storage = [Weak<Key>: Value]()
    
    func value(key: Key) -> Value? {
        storage[Weak(key)]
    }
    
    func setValue(key: Key, value: Value?) {
        if let value {
            let weakKey = Weak(key)
            storage[weakKey] = value
            let deinitHandeler = DeinitHandler { [weak self] in
                self?.storage.removeValue(forKey: weakKey)
            }
            objc_setAssociatedObject(
                key,
                AssociatedKey.weak,
                deinitHandeler,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        } else {
            storage.removeValue(forKey: Weak(key))
        }
    }
}
