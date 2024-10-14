//
//  ViewModelStorage.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

enum ViewModelStorage {
    typealias View = AnyObject
    typealias ViewModel = AnyObject
    
    private static var storage = WeakStorage<View, ViewModel>()
    
    static func value<T: View, U: ViewModel>(
        view key: T,
        viewModelType: U.Type
    ) -> U? {
        storage.value(key: key) as? U
    }
    
    static func setValue<T: View, U: ViewModel>(
        view key: T,
        viewModel value: U?
    ) {
        storage.setValue(key: key, value: value)
    }
}
