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
    
    func transform(input: Input, disposeBag: inout DisposeBag) -> Output
}
