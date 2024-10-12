//
//  MultiImageScrollView.swift
//  Coin
//
//  Created by gnksbm on 10/12/24.
//

import UIKit

import CoinFoundation

import Neat
import Kingfisher

final class MultiImageScrollView: BaseView {
    var axis = NSLayoutConstraint.Axis.horizontal {
        didSet {
            stackView.axis = axis
        }
    }
    private let scrollView = UIScrollView()
    
    private lazy var stackView = UIStackView().nt.configure {
        $0.spacing(Design.Padding.regular)
            .distribution(.equalSpacing)
    }
    
    func updateView(with urls: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        urls.forEach { urlStr in
            let imageView = UIImageView().nt.configure {
                $0.contentMode(.scaleAspectFill)
                    .layer.cornerRadius(Design.Radius.regular)
                    .clipsToBounds(true)
            }
            stackView.addArrangedSubview(imageView)
            imageView.kf.setImage(with: URL(string: urlStr))
            imageView.widthAnchor.constraint(equalTo: stackView.heightAnchor)
                .isActive = true
        }
    }
    
    override func configureLayout() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(scrollView.contentLayoutGuide)
                .inset(20)
            make.verticalEdges.equalTo(scrollView.contentLayoutGuide)
        }
    }
}
