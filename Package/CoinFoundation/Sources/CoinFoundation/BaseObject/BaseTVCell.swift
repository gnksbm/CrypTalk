//
//  File.swift
//  
//
//  Created by gnksbm on 8/29/24.
//

#if canImport(UIKit)
import UIKit

open class BaseTVCell: UITableViewCell {
    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

