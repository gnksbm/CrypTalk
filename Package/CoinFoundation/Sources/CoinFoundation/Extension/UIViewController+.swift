//
//  UIViewController.swift
//  
//
//  Created by gnksbm on 8/28/24.
//

#if canImport(UIKit)
import UIKit

import RxSwift
import RxCocoa

public extension UIViewController {
    var safeArea: UILayoutGuide { view.safeAreaLayoutGuide }
    
    var viewDidLoadEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewDidLoad)).map { _ in }
    }
    
    var viewWillAppearEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewWillAppear)).map { _ in }
    }
    
    var viewDidAppearEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewDidAppear)).map { _ in }
    }
    
    var viewWillDisappearEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewWillDisappear)).map { _ in }
    }
    
    var viewDidDisappearEvent: Observable<Void> {
        rx.methodInvoked(#selector(Self.viewDidDisappear)).map { _ in }
    }
}
#endif
