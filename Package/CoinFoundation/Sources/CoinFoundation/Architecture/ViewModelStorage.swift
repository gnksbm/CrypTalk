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
    
    static var storage = WeakStorage<View, ViewModel>()
}
