//
//  PurchaseCoinViewController.swift
//  Coin
//
//  Created by gnksbm on 9/1/24.
//

import UIKit
import WebKit

import CoinFoundation
import Domain

import iamport_ios
import Kingfisher
import Neat
import RxCocoa
import RxSwift
import SnapKit

final class PurchaseCoinViewController: BaseViewController, ViewType {
    private let iconImageView = UIImageView().nt.configure {
        $0.contentMode(.scaleAspectFill)
            .clipsToBounds(true)
    }
    private let titleButton = UIButton(configuration: .plain()).nt.configure {
        $0.configuration.titleAlignment(.leading)
            .configuration.baseForegroundColor(Design.Color.whiteForeground)
            .setContentCompressionResistancePriority(
                .required,
                for: .horizontal
            )
            .configuration.image(Design.ImageLiteral.bottomArrow)
            .configuration.imagePlacement(.trailing)
            .configuration.imagePadding(Design.Padding.regular)
    }
    private let amountTextField = UITextField().nt.configure {
        $0.borderStyle(.roundedRect)
            .placeholder("구매 수량을 입력해주세요")
            .keyboardType(.numberPad)
    }
    private let purchaseButton = UIButton.largeBorderedButton(title: "구매하기")
    
    init(viewModel: PurchaseCoinViewModel) {
        super.init()
        self.viewModel = viewModel
        configureAmountTextField()
    }
    
    func bind(viewModel: PurchaseCoinViewModel) {
        let paymentResult = PublishSubject<IamportResponse?>()
        let output = viewModel.transform(
            input: PurchaseCoinViewModel.Input(
                viewWillAppearEvent: viewWillAppearEvent,
                changeButtonTapEvent: titleButton.rx.tap.asObservable(),
                amountChangeEvent: amountTextField.rx.text.orEmpty
                    .asObservable(),
                purchaseButtonTapped: purchaseButton.rx.tap.asObservable(),
                paymentResult: paymentResult
            ),
            disposeBag: &disposeBag
        )
        
        disposeBag.insert {
            output.startSearchFlow
                .bind(with: self) { vc, _ in
                    let searchViewModel = SearchCoinViewModel(
                        searchCoinUseCase: DefaultSearchCoinUseCase(),
                        viewType: .dismiss
                    )
                    searchViewModel.delegate = viewModel
                    vc.navigationController?.pushViewController(
                        SearchCoinViewController(viewModel: searchViewModel),
                        animated: true
                    )
                }
            
            output.selectedCoin
                .bind(with: self) { vc, response in
                    vc.iconImageView.kf.setImage(with: response.imageURL)
                    vc.titleButton.configuration?.title = response.name
                }
            
            output.startPurchaseFlow
                .bind(with: self) { vc, payment in
                    if let navController = vc.navigationController {
                        Iamport.shared.payment(
                            navController: navController,
                            userCode: "imp57573124",
                            payment: payment
                        ) { response in
                            paymentResult.onNext(response)
                        }
                    }
                }
            
            output.finishFlow
                .bind(with: self) { vc, _ in
                    vc.navigationController?.popViewController(animated: true)
                }
        }
    }
    
    override func configureLayout() {
        [
            iconImageView,
            titleButton,
            amountTextField,
            purchaseButton
        ].forEach { view.addSubview($0) }
        
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeArea)
                .inset(Design.Padding.regular)
            make.size.equalTo(Design.Dimension.symbolSize)
        }
        
        titleButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing)
                .offset(Design.Padding.regular)
            make.trailing.lessThanOrEqualTo(safeArea)
                .inset(Design.Padding.regular)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom)
                .offset(Design.Padding.regular)
            make.horizontalEdges.equalTo(safeArea).inset(Design.Padding.regular)
        }
        
        purchaseButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea)
                .inset(Design.Padding.regular)
            make.horizontalEdges.equalTo(amountTextField)
        }
    }
    
    private func configureAmountTextField() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .withUnretained(self)
            .bind { vc, _ in
                vc.amountTextField.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}
