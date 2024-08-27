//
//  ViewType.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import RxSwift

public protocol ViewType: AnyObject {
    associatedtype ViewModel: ViewModelType
    
    var viewModel: ViewModel? { get set }
    
    var disposeBag: DisposeBag { get set }
    
    func bind(viewModel: ViewModel)
}

extension ViewType {
    var viewModel: ViewModel?  {
        get {
            ViewModelStorage.storage.value(key: self) as? ViewModel
        }
        set {
            ViewModelStorage.storage.setValue(key: self, value: newValue)
            if let newValue {
                bind(viewModel: newValue)
            }
        }
    }
}
