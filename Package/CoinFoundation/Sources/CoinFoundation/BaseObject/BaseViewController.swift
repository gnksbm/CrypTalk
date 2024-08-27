//
//  BaseViewController.swift
//
//
//  Created by gnksbm on 8/27/24.
//

#if canImport(UIKit)
import UIKit

import RxSwift

open class BaseViewController: UIViewController {
    public var disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }
    
    func configureUI() { }
    func configureLayout() { }
}
#endif
