//
//  ViewModelType.swift
//
//
//  Created by gnksbm on 8/27/24.
//

import Foundation

import RxSwift

public protocol ViewModelType: AnyObject { 
    associatedtype Input
    associatedtype Output
    
    func bind(input: Input, disposeBag: inout DisposeBag)
}
