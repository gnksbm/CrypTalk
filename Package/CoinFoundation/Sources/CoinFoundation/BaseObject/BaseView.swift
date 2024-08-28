//
//  File.swift
//  
//
//  Created by gnksbm on 8/29/24.
//

#if canImport(UIKit)
import UIKit

import RxSwift

open class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureUI() { }
    open func configureLayout() { }
}
#endif
