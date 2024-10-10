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
    private let directionTitleLabel = UILabel().nt.configure {
        $0.text("의견")
            .textColor(Design.Color.foreground)
    }
    private let directionPicker = UIPickerView().nt.configure {
        $0
    }
    private let contentTitleLabel = UILabel().nt.configure {
        $0.text("내용")
            .textColor(Design.Color.foreground)
    }
    private let contentTextView = UITextView().nt.configure {
        $0.backgroundColor(Design.Color.background)
            .textColor(Design.Color.darkText)
            .layer.cornerRadius(Design.Radius.regular)
            .layer.borderWidth(1)
    }
    private let doneButton = UIButton.largeBorderedButton(title: "완료")
    
    init(viewModel: AddPostViewModel) {
        super.init()
        self.viewModel = viewModel
        configureContentTextView()
    }
    
    func bind(viewModel: AddPostViewModel) {
        let output = viewModel.transform(
            input: AddPostViewModel.Input(
                textChangeEvent: contentTextView.rx.text.orEmpty.asObservable(),
                directionChangeEvent: directionPicker.rx.itemSelected
                    .map { MarketDirection.allCases[$0.row] },
                doneButtonTapEvent: doneButton.rx.tap.asObservable()
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.directionTitles
                .bind(to: directionPicker.rx.itemTitles) { $1 }
            
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
            directionTitleLabel,
            directionPicker,
            contentTitleLabel,
            contentTextView,
            doneButton
        ].forEach { view.addSubview($0) }
        
        directionTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(safeArea)
                .inset(Design.Padding.regular)
        }
        
        directionPicker.snp.makeConstraints { make in
            make.leading.equalTo(directionTitleLabel.snp.trailing)
                .offset(Design.Padding.regular)
            make.centerY.equalTo(directionTitleLabel)
            make.trailing.equalTo(safeArea)
                .inset(Design.Padding.regular)
        }
        
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(directionPicker.snp.bottom)
            make.leading.equalTo(directionTitleLabel)
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
    
    private func configureContentTextView() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .withUnretained(self)
            .bind { vc, _ in
                vc.contentTextView.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}
