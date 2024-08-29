//
//  AddPostViewController.swift
//  Coin
//
//  Created by gnksbm on 8/29/24.
//

import UIKit

import CoinFoundation
import Domain

import RxSwift
import SnapKit
import Neat

final class AddPostViewController: BaseViewController, ViewType {
    private let contentTitleLabel = UILabel().nt.configure {
        $0.text("내용")
            .textColor(Design.Color.foreground)
    }
    private let contentTextView = UITextView().nt.configure {
        $0.backgroundColor(Design.Color.background)
            .textColor(Design.Color.foreground)
            .layer.cornerRadius(Design.Radius.regular)
            .layer.borderWidth(1)
    }
    private let doneButton = UIButton.largeBorderedButton(title: "완료")
    
    init(viewModel: AddPostViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    func bind(viewModel: AddPostViewModel) {
        let output = viewModel.transform(
            input: AddPostViewModel.Input(
                textChangeEvent: contentTextView.rx.text.orEmpty.asObservable(),
                doneButtonTapEvent: doneButton.rx.tap.asObservable()
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.doneButtonIsEnabled
                .bind(to: doneButton.rx.isEnabled)
            
            output.finishFlow
                .withUnretained(self)
                .bind { vc, _ in
                    vc.navigationController?.popViewController(animated: true)
                }
        }
    }
    
    override func configureLayout() {
        [
            contentTitleLabel,
            contentTextView,
            doneButton
        ].forEach { view.addSubview($0) }
        
        contentTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(safeArea)
                .offset(Design.Padding.regular)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(contentTitleLabel.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.equalTo(safeArea)
                .inset(Design.Padding.regular)
            make.height.equalTo(contentTextView.snp.width).multipliedBy(0.7)
        }
        
        doneButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeArea)
                .inset(Design.Padding.regular)
        }
    }
}
