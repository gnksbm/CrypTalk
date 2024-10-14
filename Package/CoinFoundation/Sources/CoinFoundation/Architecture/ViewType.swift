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

public extension ViewType {
    var viewModel: ViewModel?  {
        get {
            ViewModelStorage.value(view: self, viewModelType: ViewModel.self)
        }
        set {
            ViewModelStorage.setValue(view: self, viewModel: newValue)
            if let newValue { bind(viewModel: newValue) }
        }
    }
}
